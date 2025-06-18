//
//  ScanView.swift
//  BuahHati
//
//  Created by Hendrik Nicolas Carlo on 10/06/25.
//

import SwiftUI
import AVFoundation

enum ScanViewDestination {
    case result
}

struct ScanView: View {
    @StateObject private var cameraManager = CameraManager()
    @Environment(\.dismiss) private var dismiss
    
    @Binding var navigationPath: NavigationPath
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
                                ResultsViewComponent(label: cameraManager.classificationLabel)
                                    .padding(.bottom, -18)
                                    .onTapGesture {
                                        navigationPath.append(ScanViewDestination.result)
                                    }
                            }
                        }.frame(width: 400)
                    }
                    .frame(height: 300)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .ignoresSafeArea()
            .toolbar(.hidden, for: .tabBar)
            .navigationDestination(for: ScanViewDestination.self) { destination in
                if destination == .result {
                    
                    ScanResultView(
                        viewModel: ScanResultViewModel(ripeness: cameraManager.ripeness), navigationPath: $navigationPath)
                }
            }
        }
        .onAppear {
            print("On Appear ScanView")
            cameraManager.checkPermissions()
        }
    }
}
