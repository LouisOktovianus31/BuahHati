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
                CameraController(cameraManager: cameraManager)
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
                if cameraManager.capturedImage != nil {
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
