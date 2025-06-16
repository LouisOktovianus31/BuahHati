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
//            viewfinder
               if cameraManager.capturedImage == nil {
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
                    VStack(alignment: .trailing){
                        Spacer()
                        Button {
                            cameraManager.stopSession()
                            cameraManager.startSession()
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .offset(y:25)
                        HStack{
                            if !cameraManager.classificationLabel.isEmpty && cameraManager.capturedImage != nil {
                                ResultsView(label: cameraManager.classificationLabel)
                                    .padding(.bottom, -25)
                            }
                        }.frame(width: 400)
                    }
                    .frame(height: 300)
                    .frame(maxHeight: .infinity, alignment: .bottom)
//                    .background(.black.opacity(0.3))
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            cameraManager.checkPermissions()
        }
    }
}
