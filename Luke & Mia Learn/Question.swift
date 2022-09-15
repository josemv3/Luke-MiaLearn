//  miABCQuiz: Question
//  Question.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/14/22.
//

import Foundation

struct Quesion {
    let qImage: String
    let qAudio: String
    var qChoices: [String]
    let qAnswer: String
}

//or enum with array size
//easy 4 size array, medium, 6 array and shuffle, hard 10 array and shuffle

//Build dictionary letter is key and Question is value.
