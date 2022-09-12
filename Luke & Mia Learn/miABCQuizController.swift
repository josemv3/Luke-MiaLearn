//
//  miABCQuizController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/11/22.
//

import UIKit
import AVFoundation
import AVKit

let videoNames: [String] = ["apple", "bat", "cat", "dog", "egg", "frog", "giraffe", "hedgehog"]
var videoCount = 0

private let largeBorderSize: CGFloat = 10

class miABCQuizController: UIViewController {

    @IBOutlet var mainView: UIImageView!
    @IBOutlet var mainViewButton: UIButton!
    
    var audioPlayer: AVAudioPlayer!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.borderColor = UIColor(named: "quizBrownLight")?.cgColor
        mainView.layer.borderWidth = largeBorderSize
        //viewDidAppear(true)
        navigationItem.title = "miABC Quiz"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: videoNames[videoCount], ofType: "mp4") ?? "apple.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = mainView.bounds
        mainView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player = nil
        playerLayer.removeFromSuperlayer()
    }
    
    @IBAction func mainViewButtonTap(_ sender: UIButton) {
        videoCount += 1
        if videoCount >= videoNames.count {
            videoCount = 0
        }
        viewDidDisappear(true)
        viewDidAppear(true)
        
        
    }
}
