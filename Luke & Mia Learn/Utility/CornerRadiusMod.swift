//
//  CornerRadiusMod.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/13/23.
//

import UIKit

enum CornerRadiusMod: CGFloat {
    case small, normal, large
    
    var size: CGFloat {
        switch(self) {
        case .small:
            return 5
        case .normal:
            return 10
        case .large:
            return 15
        }
    }
}
