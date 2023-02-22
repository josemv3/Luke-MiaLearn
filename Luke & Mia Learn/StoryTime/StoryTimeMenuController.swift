//
//  StoryTimeController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 10/2/22.
//

import UIKit

class StoryTimeMenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: Colors.quizDarkBrown.rawValue)
    }


}
