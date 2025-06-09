import AVFoundation
import CoreML
import Vision

class CameraManager: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var isAuthorized = true
    @Published var permissionMessage = ""
    @Published var isCameraRunning = false
    @Published var classificationLabel: String = "" // Stores the predicted label
    @Published var classificationConfidence: Double = 0.0 // Stores the confidence score
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var visionModel: VNCoreMLModel?
    
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
        session.sessionPreset = .high
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            permissionMessage = "Unable to access camera."
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        // Add video data output for real-time frame processing
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
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
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return previewLayer
    }
    
    // Handle camera frame for inference
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
              let visionModel = visionModel else { return }
        
        let request = VNCoreMLRequest(model: visionModel) { [weak self] request, error in
            guard let self = self,
                  let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else { return }
            
            DispatchQueue.main.async {
                self.classificationLabel = topResult.identifier
                self.classificationConfidence = Double(topResult.confidence)
            }
        }
        
        // Assuming the model expects 224x224 input (adjust if different)
        request.imageCropAndScaleOption = .centerCrop
        
        do {
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
        } catch {
            print("Vision request failed: \(error)")
        }
    }
}
