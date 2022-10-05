//
//  StoryTimeController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 10/3/22.
//

import UIKit

class StoryTimeController: UIViewController {
    
    @IBOutlet weak var storyMainView: UIImageView!
    @IBOutlet weak var storyPlayBtn: UIButton!
    @IBOutlet weak var storyBackBtn: UIButton!
    @IBOutlet weak var storyNextBtn: UIButton!
    var imageCount = 0
    let dragonImages = ["dragon1","dragon2","dragon3","dragon4","dragon5","dragon6","dragon7","dragon8","dragon9","dragon10", "dragon11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyMainView.image = UIImage(named: dragonImages[imageCount])
        // Do any additional setup after loading the view.
    }
    

    @IBAction func storyPlayBtnTap(_ sender: UIButton) {
    }
    

    @IBAction func storyBackBtnTap(_ sender: UIButton) {
        
    }
    
    @IBAction func storyNextBtnTap(_ sender: UIButton) {
        imageCount += 1
        let dragonCount = dragonImages.count - 1
        storyMainView.image = UIImage(named: dragonImages[imageCount])
        if imageCount == dragonCount {
            imageCount = 0
        }
        
        
    }
    
}
