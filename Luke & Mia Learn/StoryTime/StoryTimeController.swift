//
//  StoryTimeController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 10/3/22.
//

import UIKit
import AVFoundation

class StoryTimeController: UIViewController {
    
    @IBOutlet weak var storyMainView: UIImageView!
    @IBOutlet weak var storyPlayBtn: UIButton!
    @IBOutlet weak var storyBackBtn: UIButton!
    @IBOutlet weak var storyNextBtn: UIButton!
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var storyNaratorView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    var imageCount = 0
    var audioPlayer: AVAudioPlayer?
    var playerLayer = AVPlayerLayer()
    let dragonImages = ["dragon1","dragon2","dragon3","dragon4","dragon5","dragon6","dragon7","dragon8","dragon9","dragon10", "dragon11"]
    let dragonVideos = ["miaDragon1","miaDragon2","miaDragon3","miaDragon4","miaDragon5","miaDragon6","miaDragon7","miaDragon8","miaDragon9","miaDragon10", "miaDragon11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mia's Dragon Story"
        storyMainView.image = UIImage(named: dragonImages[imageCount])
        //storyLabel.text = dragonDialog[imageCount]
        storyLabel.textColor = .clear
        storyNaratorView.layer.borderWidth = BorderSize.normal.size
        storyNaratorView.layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
        storyMainView.layer.borderWidth = BorderSize.large.size
        storyMainView.layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
        bottomView.layer.borderWidth = BorderSize.large.size
        bottomView.layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
        bottomView.backgroundColor = UIColor(named: Colors.quizDarkBrown.rawValue)
    }
    
    @IBAction func storyPlayBtnTap(_ sender: UIButton) {
        //play sound
        //playSound(soundName: dragonImages[imageCount])
        playVideo(video: dragonVideos[imageCount])
        
    }

    @IBAction func storyBackBtnTap(_ sender: UIButton) {
        //audioPlayer?.stop()
        playerLayer.player?.pause()
        
        if imageCount == 0 {
            //noise?
            //alert that you hear at beginning?
        } else {
            imageCount -= 1
            storyMainView.image = UIImage(named: dragonImages[imageCount])
            //storyLabel.text = dragonDialog[imageCount]
        }
    }
    
    @IBAction func storyNextBtnTap(_ sender: UIButton) {
        //audioPlayer?.stop()
        playerLayer.player?.pause()
        
        let dragonCount = dragonImages.count - 1
        if imageCount == dragonCount {
            imageCount = 0
            storyMainView.image = UIImage(named: dragonImages[imageCount])
            //storyLabel.text = dragonDialog[imageCount]
            //audioPlayer?.play()
        } else {
            imageCount += 1
            storyMainView.image = UIImage(named: dragonImages[imageCount])
            //storyLabel.text = dragonDialog[imageCount]
            //audioPlayer?.play()
        }
    }
    
    //MARK: - Play Video
    
    func playVideo(video: String) {
        playerLayer.player?.pause()
        
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: video , ofType: "mp4") ?? "dog.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = storyNaratorView.bounds
        playerLayer.videoGravity = .resizeAspect
        storyNaratorView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    //MARK: - Sound Player
    
    func playSound(soundName: String) {
        
        let urlString = Bundle.main.path(forResource: soundName, ofType: "mp3")
        let pathToSound = Bundle.main.path(forResource: soundName, ofType: ".mp3") ?? "a.mp3"
        let url = URL(fileURLWithPath: pathToSound)
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 0.50
            audioPlayer?.play()
            guard let audioPlayer = audioPlayer else {
                return
            }
            audioPlayer.play()
            
        } catch {
            print("PlaySound StoryTimeController error")
        }
    }
}
