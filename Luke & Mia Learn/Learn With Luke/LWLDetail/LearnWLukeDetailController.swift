//
//  LearnWLukeDetailController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/23/22.
//

import UIKit
import AVFoundation

class LearnWLukeDetailController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var topButtonsRight: UIButton!
    @IBOutlet weak var topButtonLeft: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var bottomButtonsRight: UIButton!
    @IBOutlet weak var bottomButtonLeft: UIButton!
    
    var learnWLukeLessonChoice = ""
    var audioPlayer: AVAudioPlayer!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    private var learnWLukeVideos: [String: String] = ["Asteroid belt": "asteroid1"]
    private var learnWLukeInfo = [
        "Scattered in orbits around the sun are bits and pieces of rock left over from the beginning of the solar system. Most of these objects are asteroids.",
        "The asteroid belt is located between Mars and Jupiter, the 4th and 5th planets in our solar system.",
        "Unlike Earths moon, asteroids are not made of cheese but are different types of rocks. ",
        "To be an asteroid you must be about 10 meters or over 32 feet! Thats bigger than a person, elephant, or Monster truck!"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = learnWLukeInfo[0]
        topButtonLeft.setTitle(learnWLukeLessonChoice, for: .normal)
        topButtonLeft.setTitleColor(.black, for: .normal)
        //topButtonLeft.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        navigationItem.title = "Asteroid Belt"
        //navigationController?.navigationBar.backgroundColor = UIColor.green

        
    }
    
    //MARK: - ViewDidApear Video Player
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor(named: "learnWLukePurple")
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: learnWLukeVideos[learnWLukeLessonChoice], ofType: "mp4") ?? "apple.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = mainImage.bounds
        mainImage.layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player = nil
        playerLayer.removeFromSuperlayer()
    }
    
    @IBAction func topBtnTap(_ sender: UIButton) {
    }
    
    @IBAction func bottomBtnTap(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
