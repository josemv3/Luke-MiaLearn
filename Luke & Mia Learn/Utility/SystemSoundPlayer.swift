//
//  SystemSoundPlayer.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/24/23.
//

import AVFoundation

struct SystemSoundPlayer {
    
    static let shared = SystemSoundPlayer()
    
    func clickSound() {
        let systemSoundID: SystemSoundID = 1104 //1006
        AudioServicesPlaySystemSound (systemSoundID)
    }
}
