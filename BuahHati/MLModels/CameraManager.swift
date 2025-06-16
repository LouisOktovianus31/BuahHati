import AVFoundation
import CoreML
import Vision
import UIKit
import SwiftUI

class CameraManager: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    @Published var isAuthorized = true
    @Published var permissionMessage = ""
    @Published var isCameraRunning = false
    @Published var detectedObjects: [(label: String, boundingBox: CGRect)] = []
    @Published var isCentered = false
    @Published var classificationLabel: String = ""
    @Published var classificationConfidence: Double = 0.0
    @Published var capturedImage: UIImage?
    private let session = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var photoOutput: AVCapturePhotoOutput?
    private var detectionModel: VNCoreMLModel?
    private var classificationModel: VNCoreMLModel?
    private var requests: [VNRequest] = []
    private var viewSize: CGSize = .zero
    
    @Published var isAvocado = false
    
    override init() {
        super.init()
        setupSession()
        setupVisionModels()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
            startSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.isAuthorized = granted
                    self.permissionMessage = granted ? "" : "Camera access denied. Please enable in Settings."
                    if granted {
                        self.startSession()
                    }
                }
            }
        case .denied, .restricted:
            isAuthorized = false
            permissionMessage = "Camera access denied. Please enable in Settings."
        @unknown default:
            isAuthorized = false
            permissionMessage = "Unknown permission status."
        }
    }
    
    private func setupSession() {
        session.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            permissionMessage = "Unable to access camera."
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        photoOutput = AVCapturePhotoOutput()
        if let photoOutput = photoOutput, session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
    }
    
    private func setupVisionModels() {
        // Setup detection model (AvocadoDetector)
        guard let detectionMLModel = try? AvocadoDetector_yolov2(configuration: MLModelConfiguration()) else {
            print("Failed to load AvocadoDetector model.")
            return
        }
        do {
            detectionModel = try VNCoreMLModel(for: detectionMLModel.model)
            let detectionRequest = VNCoreMLRequest(model: detectionModel!) { [weak self] request, error in
                guard let self = self, let results = request.results as? [VNRecognizedObjectObservation] else { return }
                
                let detected = results.map { observation in
                    let boxInView = VNImageRectForNormalizedRect(observation.boundingBox, Int(self.viewSize.width), Int(self.viewSize.height))
                    return (label: observation.labels.first?.identifier ?? "Unknown", boundingBox: boxInView)
                }
                
                let isCentered = self.isAnyBoundingBoxCentered(detected.map { $0.boundingBox })
                let hasAvocado = detected.contains { $0.label.lowercased().contains("avocado") }
                
                DispatchQueue.main.async {
                    self.detectedObjects = detected
                    self.isCentered = isCentered
                    self.isAvocado = isCentered && hasAvocado && !detected.isEmpty
                }
            }
            requests = [detectionRequest]
        } catch {
            print("Failed to create detection Vision model: \(error)")
        }
        
        // Setup classification model (avocado_v1_60)
        guard let classificationMLModel = try? AvocadoClassifier3_class(configuration: MLModelConfiguration()) else {
            print("Failed to load avocado_v1_60 model.")
            return
        }
        do {
            classificationModel = try VNCoreMLModel(for: classificationMLModel.model)
        } catch {
            print("Failed to create classification Vision model: \(error)")
        }
    }
    
    private func isAnyBoundingBoxCentered(_ boundingBoxes: [CGRect]) -> Bool {
        let insetRatio: CGFloat = 0.2
        let centerRegion = CGRect(x: viewSize.width * insetRatio, y: viewSize.height * insetRatio,
                                  width: viewSize.width * (1 - 2 * insetRatio), height: viewSize.height * (1 - 2 * insetRatio))
        
        return boundingBoxes.contains { box in
            centerRegion.contains(box)
        }
    }
    
    func startSession(viewSize: CGSize = .zero) {
        self.viewSize = viewSize
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                self.isCameraRunning = true
                self.isAvocado = false
            }
        }
    }
    
    func stopSession() {
        session.stopRunning()
        DispatchQueue.main.async {
            self.isCameraRunning = false
            self.detectedObjects = []
            self.isCentered = false
            self.classificationLabel = ""
            self.classificationConfidence = 0.0
            self.capturedImage = nil
            self.isAvocado = false
        }
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return previewLayer
    }
    
    func capturePhoto() {
        guard let photoOutput = photoOutput else { return }
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])
        try? handler.perform(requests)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let uiImage = UIImage(data: imageData),
              let ciImage = CIImage(data: imageData),
              let classificationModel = classificationModel else {
            print("Failed to process captured photo")
            return
        }
        
        DispatchQueue.main.async {
            self.capturedImage = uiImage
        }
        
        let request = VNCoreMLRequest(model: classificationModel) { [weak self] request, error in
            guard let self = self,
                  let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                print("No classification results")
                return
            }
            
            DispatchQueue.main.async {
                self.classificationLabel = topResult.identifier
                self.classificationConfidence = Double(topResult.confidence)
            }
        }
        
        request.imageCropAndScaleOption = .centerCrop
        
        do {
            let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
            try handler.perform([request])
        } catch {
            print("Classification request failed: \(error)")
        }
    }
}
