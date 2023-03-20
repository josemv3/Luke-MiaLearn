//
//  Titles.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/17/23.
//

import Foundation

enum Title: String {
    case Menu = "Menu"
    case MiaLearns = "Mia Learns"
    case MiaAbcQuiz = "Mia ABC Quiz"
    case LearnWithLuke = "Learn With Luke"
    case MiaTalksMenu = "Mia Talks Menu"
    case MiaTalks = "Mia Talks"
    case StoryTime = "Story Time"
    case FindMe = "Find Me"
    case LukeTalks = "Luke Talks"
    
    enum Story: String {
        case miasDragonStory = "Mia's Dragon Story"
    }
    
    enum ViewNames: String, CaseIterable {
        case Header, Footer
    }
    
    enum Font: String, CaseIterable {
        case Chalkduster
    }
}
