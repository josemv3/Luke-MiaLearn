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
        navigationItem.title = Title.MiaTalksMenu.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: Colors.miaTalksOrange.rawValue)
    }
}
