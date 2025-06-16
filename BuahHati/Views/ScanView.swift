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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Camera preview or captured image
            if let capturedImage = cameraManager.capturedImage {
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                CameraController(cameraManager: cameraManager)
                    .ignoresSafeArea()
            }
            
            VStack {
                // Classification results or viewfinder
                if !cameraManager.classificationLabel.isEmpty && cameraManager.capturedImage != nil {
                    ResultsView(label: cameraManager.classificationLabel)
//                        .frame(maxHeight: .infinity, alignment: .bottom)
//                        .padding(.bottom, -25)
                } else if cameraManager.capturedImage == nil {
                    Spacer()
                    Image(systemName: "viewfinder")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .foregroundColor(cameraManager.isAvocado ? Color("PrimaryColor") : .white)
                }
                
                Spacer()
                
                // Action buttons
                if cameraManager.capturedImage == nil {
                    Button {
                        cameraManager.capturePhoto()
                    } label: {
                        Image(systemName: "button.programmable")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .padding()
                            .foregroundColor(cameraManager.isAvocado ? .white : Color("InactiveColor"))
                    }
                    .disabled(!cameraManager.isAvocado)
                    .padding()
                } else {
                    Button {
                        cameraManager.stopSession()
                        cameraManager.startSession()
                    } label: {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            cameraManager.checkPermissions()
        }
    }
}
