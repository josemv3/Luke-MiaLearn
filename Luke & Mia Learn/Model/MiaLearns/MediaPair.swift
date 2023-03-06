//
//  MediaPair.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/31/22.
//

import UIKit

protocol MediaPair {
    var imageName: String { get set }
    var soundName: String { get set }
}

struct LessonPrompt: MediaPair {
    var imageName: String
    var soundName: String
}

struct LessonItem: MediaPair {
    var imageName: String
    var soundName: String //could make this = imageName
}
