//
//  MiaAbcQuizData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/15/23.
//

import Foundation

struct MiaAbcQuizData {
    
    var videoNamesArray = [String]()
    var currentLetterSet = [String]()
    var quizAlphabetLetters = [String]()
    
    mutating func getVideoNames() {
        videoNamesArray = VideoNames.allCases.map { $0.rawValue }
    }
    
    mutating func getLetterSet() {
        currentLetterSet = Letters.a.letterSet
        quizAlphabetLetters = Letters.a.letterSet
    }
    
    enum VideoNames: String, CaseIterable {
        case
        apple, bat, cat, dog, egg,
        frog, giraffe, hedgehog, icecream, jump,
        kite, love, moon, numbers, owl,
        pancake,question, rocket, snake, tree,
        umbrella, volcano, wolf, xray, yoga, zoo
    }
    
    enum Letters: String, CaseIterable {
        case a, b, c, d, e, f,
             g, h, i, j, k, l,
             m, n, o, p, q, r,
             s, t, u, v, w, x, y, z
        
        static let letterSets: [[Letters]] = [
            [.a, .b, .c, .d, .e, .f],
            [.f, .g, .h, .i, .j, .k],
            [.k, .l, .m, .n, .o, .p],
            [.p, .q, .r, .s, .t, .u],
            [.u, .v, .w, .x, .y, .z]
        ]
        
        var letterSet: [String] {
            guard let letterSet = Letters.letterSets.first(where: { $0.contains(self) }) else {
                return []
            }
            return letterSet.map { $0.rawValue }
        }
    }
    
    mutating func changeLetterSet(correctAnswer: String) {
        switch correctAnswer {
        case "f"..."j":
            quizAlphabetLetters = Letters.g.letterSet
        case "k"..."o":
            quizAlphabetLetters = Letters.l.letterSet
        case "p"..."t":
            quizAlphabetLetters = Letters.q.letterSet
        case "u"..."z":
            quizAlphabetLetters = Letters.v.letterSet
        default:
            quizAlphabetLetters = Letters.a.letterSet
        }
    }
    
    func getShuffledLetterSet() -> [String] {
        return quizAlphabetLetters.shuffled()
    }
    
    //could actually use same enum Letters and add a Quiz.raw to each letter
    enum LetterImageName: String, CaseIterable {
        case Quiz
    }
}



//    mutating func makeVideoNameArray() -> [String] {
//        return VideoNames.allRawValues
//    }

//    mutating func makeLetterSet() -> [String] {
//        return Letters.a.letterSet
//    }
