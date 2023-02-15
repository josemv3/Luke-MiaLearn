//
//  LukeTalksHeader.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 1/3/23.
//

import UIKit
import AVFoundation
import AVKit

class LukeTalksHeader: UICollectionReusableView {
    let lukeTalksHeaderImage = UIImageView()
    let lukeTalksHeaderLabel = UILabel()
    var headerCurrentVideo = "human_aquarium"
    
    var playerLayer = AVPlayerLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func configure(text: String, image: UIImage) {
        // Update label text and image here...
    }
    
    func setupViews() {
        
        lukeTalksHeaderImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lukeTalksHeaderImage)
        
        NSLayoutConstraint.activate([
            lukeTalksHeaderImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lukeTalksHeaderImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lukeTalksHeaderImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            lukeTalksHeaderImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
        
        lukeTalksHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lukeTalksHeaderLabel)

        NSLayoutConstraint.activate([
            lukeTalksHeaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lukeTalksHeaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lukeTalksHeaderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            lukeTalksHeaderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
      }
    
    func playVideo() {
        playerLayer.player?.pause() //if player exists pause playback and start new play

        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: headerCurrentVideo , ofType: "mp4") ?? "human_draw.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = lukeTalksHeaderImage.bounds
        playerLayer.videoGravity = .resizeAspect
        lukeTalksHeaderImage.layer.addSublayer(playerLayer)
        player.play()
    }
}


//Extra:

//        func configureVideo(videoURL: URL) {
//            createPlayer(withURL: videoURL)
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = lukeTalksHeaderImage.bounds
//            lukeTalksHeaderImage.layer.addSublayer(playerLayer)
//        }
