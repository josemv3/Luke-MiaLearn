//
//  Button.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/22/23.
//

import UIKit

extension UIButton {
    var shouldRoundCorners: Bool {
        get {
            return layer.cornerRadius > 0
        }
        set {
            if newValue {
                layer.cornerRadius = 5
                clipsToBounds = true
            } else {
                layer.cornerRadius = 0
                clipsToBounds = false
            }
        }
    }
    var buttonBorderStory: Bool {
        get {
            return layer.borderWidth > 0
        }
        set {
            if newValue {
                layer.borderWidth = BorderSize.small.size
                layer.borderColor = UIColor(named: Colors.quizLightBlue.rawValue)?.cgColor
            } else {
                layer.borderWidth = 0
                layer.borderColor = nil
            }
        }
    }
}
