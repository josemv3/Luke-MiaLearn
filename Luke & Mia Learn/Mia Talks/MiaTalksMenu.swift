//
//  MiaTalksMenu.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 1/29/23.
//

import UIKit

class MiaTalksMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mia Talks"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: "miaTalksOrange")
    }
}
