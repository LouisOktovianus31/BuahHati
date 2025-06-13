//
//  ScanView.swift
//  BuahHati
//
//  Created by Hendrik Nicolas Carlo on 10/06/25.
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    @StateObject private var cameraManager = CameraManager()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Show camera preview only if no image is captured
            if cameraManager.capturedImage == nil {
                CameraPreview(cameraManager: cameraManager)
                    .ignoresSafeArea()
            } else if let image = cameraManager.capturedImage {
                // Show captured image covering the entire view
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            VStack {
                // Display classification results if available
                if !cameraManager.classificationLabel.isEmpty && cameraManager.capturedImage != nil {
                    Text("Result: \(cameraManager.classificationLabel) (\(String(format: "%.2f", cameraManager.classificationConfidence * 100))%)")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding()
                }
                
                Spacer()
                
                // Show buttons based on state
                if cameraManager.capturedImage == nil {
                    // Capture button when camera is active
                    Button(action: {
                        cameraManager.capturePhoto()
                    }) {
                        Text("Capture")
                            .font(.title3)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding()
                } else {
                    // Reset button when image is captured
                    Button(action: {
                        cameraManager.stopSession() // Clear current state
                        cameraManager.startSession() // Restart camera
                    }) {
                        Text("Reset")
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            cameraManager.checkPermissions()
        }
    }
}

// Camera preview representable
struct CameraPreview: UIViewControllerRepresentable {
    @ObservedObject var cameraManager: CameraManager
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        if let layer = cameraManager.getPreviewLayer() {
            layer.frame = controller.view.bounds
            controller.view.layer.addSublayer(layer)
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let layer = cameraManager.getPreviewLayer() {
            layer.frame = uiViewController.view.bounds
        }
    }
}
