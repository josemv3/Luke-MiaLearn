//
//  QuizBrain.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/14/22.
//

import Foundation

struct QuizBrain {
    
    let quiz: [String: Quesion] = [
        "a": Quesion(qImage: "apple", qAudio: "apple", qChoices: ["aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "a"),
        "b": Quesion(qImage: "bat", qAudio: "bat", qChoices: ["aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "c"),
        "c": Quesion(qImage: "cat", qAudio: "cat", qChoices: ["aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "c"),
        "d": Quesion(qImage: "dog", qAudio: "dog", qChoices: ["aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "d"),
        "e": Quesion(qImage: "egg", qAudio: "egg", qChoices: ["aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "e"),
        "f": Quesion(qImage: "frog", qAudio: "frog", qChoices: ["aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "f"),
        "g": Quesion(qImage: "giraffe", qAudio: "giraffe", qChoices: ["gQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz"], qAnswer: "g"),
        
    ]
    
    let alphabetLetters = ["a", "b", "c", "d", "e", "f", "h", "i", "j", "k", "l" ,"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    
    
    func getLetterSet(answer: String) -> [String]{
        var selectedLetters: [String] = []
        var count = 0
        for letter in alphabetLetters.shuffled() {
            if count >= 5 {
                break
            }
            selectedLetters.append(letter)
            count += 1
        }
        return selectedLetters
    }
    
}
