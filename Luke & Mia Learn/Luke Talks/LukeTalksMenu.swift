//
//  LukeTalksMenu.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/9/22.
//

import UIKit

class LukeTalksMenu: UIViewController {
    
    @IBOutlet weak var lessonButton1: UIButton!
    @IBOutlet weak var lessonButton2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func lessonButtonPushed(_ sender: UIButton) {
        
        if sender == lessonButton1 {
            performSegue(withIdentifier: "goToLukeTalks", sender: self)
        } else {
            performSegue(withIdentifier: "goToLukeTalks2", sender: self)
        }
    }
}
