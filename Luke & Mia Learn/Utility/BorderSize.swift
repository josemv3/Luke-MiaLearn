//
//  BorderSIze.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/13/23.
//

import UIKit

enum BorderSize: CGFloat {
    case small, normal, large, xLarge
    
    var size: CGFloat {
        switch(self) {
        case .small:
            return 2
        case .normal:
            return 4
        case .large:
            return 6
        case .xLarge:
            return 10
        }
    }
}
