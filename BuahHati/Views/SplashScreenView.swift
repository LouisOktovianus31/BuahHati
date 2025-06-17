//
//  SplashScreenView.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 18/06/25.
//

import SwiftUI
import AVKit

struct SplashScreenView: View {
    @State private var isActive = false
    private let player = AVPlayer(url: Bundle.main.url(forResource: "Logo Buah Hati Splash", withExtension: "mp4")!)

    var body: some View {
        Group {
            if isActive {
                ContentView()
                    .animation(.default)
            } else {
                CustomPlayerView(player: player)
                    .ignoresSafeArea()
                    .onAppear {
                        player.play()
                        DispatchQueue.main.asyncAfter(deadline: .now() + player.currentItem!.asset.duration.seconds) {
                            isActive = true
                        }
                    }
            }
        }
    }
}

// MARK: - Fullscreen Custom Player
struct CustomPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill // ⬅️ Pastikan fill layar
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

#Preview {
    SplashScreenView()
}

