//
//  ContentView.swift
//  BuahHati
//
//  Created by Louis Oktovianus on 09/06/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    
    var body: some View {
        ZStack {
            if cameraManager.isAuthorized {
                if cameraManager.isCameraRunning {
                    CameraView(cameraManager: cameraManager)
                        .ignoresSafeArea()
                    // Quit button and label
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            // Display label and confidence
                            if !cameraManager.classificationLabel.isEmpty {
                                Text("\(cameraManager.classificationLabel) (\(String(format: "%.2f", cameraManager.classificationConfidence * 100))%)")
                                    .font(.title3)
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Button(action: {
                                cameraManager.stopSession()
                            }) {
                                Text("Quit")
                                    .font(.title3)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .padding()
                        }
                        .padding(.trailing)
                    }
                } else {
                    Text("Camera Stopped")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .ignoresSafeArea()
                }
            } else {
                Text(cameraManager.permissionMessage)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .onAppear {
            cameraManager.checkPermissions()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
