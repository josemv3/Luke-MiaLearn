//
//  FindMeMenu.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 1/27/23.
//

import UIKit

class FindMeMenu: UIViewController {

    
    @IBOutlet weak var imageViewOne: UIImageView!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var imageViewThree: UIImageView!
    
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Find me"
        
        imageViewOne.layer.borderWidth = 3
        imageViewOne.layer.borderColor = UIColor(named: "findmeOrange")?.cgColor
        imageViewOne.layer.cornerRadius = 5
        buttonOne.tintColor = UIColor(named: "findmeOrange")
        
        imageViewTwo.layer.borderWidth = 3
        imageViewTwo.layer.borderColor = UIColor.systemIndigo.cgColor
        imageViewTwo.layer.cornerRadius = 5
        buttonTwo.layer.cornerRadius = 5
        
        imageViewThree.layer.borderWidth = 3
        imageViewThree.layer.cornerRadius = 5
        imageViewThree.layer.borderColor = UIColor.systemGreen.cgColor
        buttonThree.layer.cornerRadius = 5
    }
}
