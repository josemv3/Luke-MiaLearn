//
//  MiaABCItem.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/1/22.
//

import Foundation

//letter image
//letter sound
//main image
//main image sound

struct MiaLearnsLessonTwo {
    let cellImage: String
    let cellImageSound: String
    let mainImageAndSound: String
    
    init(cellImage: String, cellImageSound: String, mainImageAndSound: String) {
        self.cellImage = cellImage
        self.cellImageSound = cellImageSound
        self.mainImageAndSound = mainImageAndSound
    }
}
