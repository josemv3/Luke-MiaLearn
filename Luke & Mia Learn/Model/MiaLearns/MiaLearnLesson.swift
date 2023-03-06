//
//  MiaLearnLesson2.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/31/22.
//

import Foundation

struct MiaLearnsLesson {
    var promt: LessonPrompt
    var item: LessonItem
    
    init(promt: LessonPrompt, item: LessonItem) {
        self.promt = promt
        self.item = item
    }
}
