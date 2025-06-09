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
                    // Quit button
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                cameraManager.stopSession()
                            }) {
                                Text("Quit")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .padding()
                        }
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
