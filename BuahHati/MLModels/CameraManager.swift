//
//  CameraManager.swift
//  BuahHati
//
//  Created by Hendrik Nicolas Carlo on 09/06/25.
//
import AVFoundation

class CameraManager: NSObject, ObservableObject {
    @Published var isAuthorized = true
    @Published var permissionMessage = ""
    @Published var isCameraRunning = false
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init() {
        super.init()
        setupSession()
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
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
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
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        return previewLayer
    }
}
