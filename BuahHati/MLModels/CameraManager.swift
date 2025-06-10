import AVFoundation
import CoreML
import Vision
import UIKit

class CameraManager: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isAuthorized = true
    @Published var permissionMessage = ""
    @Published var isCameraRunning = false
    @Published var classificationLabel: String = "" // Stores the predicted label
    @Published var classificationConfidence: Double = 0.0 // Stores the confidence score
    @Published var capturedImage: UIImage? // Stores the captured image
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var visionModel: VNCoreMLModel?
    private var photoOutput: AVCapturePhotoOutput?
    
    override init() {
        super.init()
        setupSession()
        setupVisionModel()
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
        
        // Add photo output for capturing still images
        photoOutput = AVCapturePhotoOutput()
        if let photoOutput = photoOutput, session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
    }
    
    private func setupVisionModel() {
        // Load the avocado_v1_60 model
        guard let model = try? avocado_v1_60(configuration: MLModelConfiguration()) else {
            print("Failed to load avocado_v1_60 model.")
            return
        }
        do {
            visionModel = try VNCoreMLModel(for: model.model)
        } catch {
            print("Failed to create Vision model: \(error)")
        }
    }
    
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                self.isCameraRunning = true
            }
        }
    }
    
    func stopSession() {
        session.stopRunning()
        isCameraRunning = false
        classificationLabel = ""
        classificationConfidence = 0.0
        capturedImage = nil
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return previewLayer
    }
    
    // Capture a single photo
    func capturePhoto() {
        guard let photoOutput = photoOutput else { return }
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // Handle captured photo
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let uiImage = UIImage(data: imageData),
              let ciImage = CIImage(data: imageData),
              let visionModel = visionModel else {
            print("Failed to process captured photo")
            return
        }
        
        // Stop the camera session
        session.stopRunning()
        DispatchQueue.main.async {
            self.isCameraRunning = false
            self.capturedImage = uiImage
        }
        
        let request = VNCoreMLRequest(model: visionModel) { [weak self] request, error in
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
            print("Vision request failed: \(error)")
        }
    }
}
