//
//  ImageView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/22/23.
//

import UIKit

extension UIImageView {
    var storyBorder: Bool {
        get {
            return layer.borderWidth > 0
        }
        set {
            if newValue {
                layer.borderWidth = BorderSize.large.size
                layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
            } else {
                layer.borderWidth = 0
                layer.borderColor = nil
            }
        }
    }
}

