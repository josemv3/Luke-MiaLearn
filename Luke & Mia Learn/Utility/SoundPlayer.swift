//
//  SoundPlayer.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/7/22.
//


import AVFoundation

class SoundPlayer {
    static let shared = SoundPlayer()
    var audioPlayer: AVAudioPlayer?
    
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
            print("error")
        }
    }
}
