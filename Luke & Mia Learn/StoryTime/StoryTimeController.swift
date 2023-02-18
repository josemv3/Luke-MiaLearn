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
    
    var imageCount = 0
    var audioPlayer: AVAudioPlayer?
    var playerLayer = AVPlayerLayer()
    let dragonImages = ["dragon1","dragon2","dragon3","dragon4","dragon5","dragon6","dragon7","dragon8","dragon9","dragon10", "dragon11"]
    let dragonVideos = ["miaDragon1","miaDragon2","miaDragon3","miaDragon4","miaDragon5","miaDragon6","miaDragon7","miaDragon8","miaDragon9","miaDragon10", "miaDragon11"]
    let dragonDialog = [
    "I want a Dragon and I can fly in the clouds and have fun with the birds",
    "Then the Dragon can make a loud noise at my brother. My brother doesn't like it. RAAaaaaAHHR!",
    "I want my Dragon can do fire. He can cook my smarshmallows",
    "I was laying at night and wishing and wishing for a Dragon. I'm wishing in my dream when I'm sleeping in the night time.",
    "Becasue I lost my stuffed Dragon at the Disney park",
    "I want my Dragon to block the sun on my way to school. It gets in my eyes.",
    "I can take my Dragon to school with me and we can have lots of fun.",
    "When I bring my Dragon to school the teachers gonna be really angry",
    "There is going to be baloons all around class. They have water and lots of flowers in them. The baloons can turn someone, when they are a stuffed animal, into a monkey or crab!",
    "So the teacher throws the wet balloon at the Dragon and he turns into a monkey and falls.",
    "My Dragon is a Monkey. The End."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyMainView.image = UIImage(named: dragonImages[imageCount])
        storyLabel.text = dragonDialog[imageCount]
        storyLabel.textColor = .white
        storyNaratorView.layer.borderWidth = 4
        storyNaratorView.layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
        storyMainView.layer.borderWidth = BorderSize.large.size
        storyMainView.layer.borderColor = UIColor(named: Colors.mainOrange.rawValue)?.cgColor
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
            storyLabel.text = dragonDialog[imageCount]
        }
    }
    
    @IBAction func storyNextBtnTap(_ sender: UIButton) {
        //audioPlayer?.stop()
        playerLayer.player?.pause()
        
        let dragonCount = dragonImages.count - 1
        if imageCount == dragonCount {
            imageCount = 0
            storyMainView.image = UIImage(named: dragonImages[imageCount])
            storyLabel.text = dragonDialog[imageCount]
            //audioPlayer?.play()
        } else {
            imageCount += 1
            storyMainView.image = UIImage(named: dragonImages[imageCount])
            storyLabel.text = dragonDialog[imageCount]
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
