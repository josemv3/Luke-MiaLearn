//
//  VideoPlayer.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 1/9/23.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayer {
    static let shared = VideoPlayer()
    var playerLayer = AVPlayerLayer()
    
    func playVideo(songName: String, viewPlayer: UIImageView) {
        playerLayer.player?.pause() //if player exists pause playback and start new play
       
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: songName , ofType: "mp4") ?? "apple.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = viewPlayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        viewPlayer.layer.addSublayer(playerLayer)
        player.play()
    }
    
}


