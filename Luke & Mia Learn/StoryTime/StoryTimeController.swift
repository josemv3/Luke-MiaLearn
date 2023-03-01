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
    @IBOutlet weak var storyPauseBtn: UIButton!
    @IBOutlet weak var storyBackBtn: UIButton!
    @IBOutlet weak var storyNextBtn: UIButton!
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var storyNaratorView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
    var storyTimeData = StoryTimeData()
    var systemSoundPlayer = SystemSoundPlayer.shared
    var videoPlayer = VideoPlayer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Title.Story.miasDragonStory.rawValue
        storyMainView.image = UIImage(named: storyTimeData.imageNames[storyTimeData.mediaCount])
        storyLabel.textColor = .clear
        bottomView.storyBorderPlus =  true
        storyNaratorView.storyBorder = true
        storyMainView.storyBorder = true
        storyBackBtn.shouldRoundCorners = true
        storyBackBtn.buttonBorderStory = true
        storyNextBtn.shouldRoundCorners = true
        storyNextBtn.buttonBorderStory = true
        storyPauseBtn.shouldRoundCorners = true
        storyPauseBtn.buttonBorderStory = true
        storyPlayBtn.shouldRoundCorners = true
        storyPlayBtn.buttonBorderStory = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        videoPlayer.playerLayer.player?.pause()
    }
    
    @IBAction func storyPlayBtnTap(_ sender: UIButton) {
        systemSoundPlayer.clickSound()
        videoPlayer.playVideo(videoName: storyTimeData.videoNames[storyTimeData.mediaCount], viewPlayer: storyNaratorView)
    }
    
    @IBAction func storyPauseBtnTap(_ sender: UIButton) {
        systemSoundPlayer.clickSound()
        videoPlayer.playerLayer.player?.pause()
    }
    
    @IBAction func storyBackBtnTap(_ sender: UIButton) {
        systemSoundPlayer.clickSound()
        videoPlayer.playerLayer.player?.pause()
        
        if storyTimeData.mediaCount == 0 {
           
        } else {
            storyTimeData.mediaCount -= 1
            storyMainView.image = UIImage(named: storyTimeData.imageNames[storyTimeData.mediaCount])
        }
    }
    
    @IBAction func storyNextBtnTap(_ sender: UIButton) {
        systemSoundPlayer.clickSound()
        videoPlayer.playerLayer.player?.pause()
        let dragonCount = storyTimeData.imageNames.count - 1
        if storyTimeData.mediaCount == dragonCount {
            storyTimeData.mediaCount = 0
            storyMainView.image = UIImage(named: storyTimeData.imageNames[storyTimeData.mediaCount])
        } else {
            storyTimeData.mediaCount += 1
            storyMainView.image = UIImage(named: storyTimeData.imageNames[storyTimeData.mediaCount])
        }
    }
}


