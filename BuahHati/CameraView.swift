//
//  CameraView.swift
//  BuahHati
//
//  Created by Hendrik Nicolas Carlo on 09/06/25.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
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

