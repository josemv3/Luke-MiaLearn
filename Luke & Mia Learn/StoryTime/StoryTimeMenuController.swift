//
//  StoryTimeController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 10/2/22.
//

import UIKit

class StoryTimeMenuController: UIViewController {
    @IBOutlet weak var dragonStoryBtn: UIButton!

    let systemSoundPlayer = SystemSoundPlayer.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Title.StoryTime.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: Colors.quizDarkBrown.rawValue)
    }

    @IBAction func dragonStoryBtnPress(_ sender: UIButton) {
        systemSoundPlayer.clickSound()
        performSegue(withIdentifier: SegueId.gotoStoryTime.rawValue, sender: self)
    }
}
