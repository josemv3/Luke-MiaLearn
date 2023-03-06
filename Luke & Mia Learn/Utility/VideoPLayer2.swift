//
//  VideoPLayer2.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/4/23.
//
import UIKit
import AVFoundation
import AVKit

class VideoPlayer2 {
    static let shared = VideoPlayer2()
    var playerLayer = AVPlayerLayer()
    var player: AVPlayer? // Make the player property optional
    
    func playVideo(videoName: String, viewPlayer: UIImageView) {
        player?.pause() // Pause the current player if it exists
       
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: videoName , ofType: "mp4") ?? "apple.mp4"))
        self.player = player // Set the player property to the new player
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = viewPlayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        viewPlayer.layer.addSublayer(playerLayer)
        player.play()
    }
}

