//
//  MenuData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/5/23.
//

import Foundation

struct MenuData {
    var menuDataFinal: [String: MenuItem] = [:]
    var snapShotItems = MenuIcons.allCases.map { "\($0)" }
    
    struct MenuItem {
        let imageName: String
        let displayName: String
        let age: String
    }
    
    enum  MenuIcons: String, CaseIterable {
        case miaLearnsLogo = "Mia learns",
             miABCQuizLogo = "Mia abc quiz",
             miaTalksLogo = "Mia talks",
             learnWLukeLogo = "Learn with luke",
             findMeLogo = "Find me",
             storyTimeLogo = "Story time",
             lukeTalksLogo = "Luke talks"
        
        var age: String {
                  switch self {
                  case .miaLearnsLogo, .storyTimeLogo:
                      return "Age: 2+"
                  case .miABCQuizLogo, .miaTalksLogo, .findMeLogo:
                      return "Age: 3+"
                  case .lukeTalksLogo:
                      return "Age: 4+"
                  case .learnWLukeLogo:
                      return "Age: 5+"
                  }
              }
    }

    func buildMenuDictionary() -> [String: MenuItem] {
        var menuDictionary: [String: MenuItem] = [:]
        //loop through MenuIcon cases
        for menuIcon in MenuIcons.allCases {
            let displayName = menuIcon.rawValue
            let age = menuIcon.age //using case to grab age
            let imageName = menuIcon.rawValue
            let menuItem = MenuItem(imageName: imageName, displayName: displayName, age: age)
            let key = "\(menuIcon)" //Make enum case a string (not the associated value)
            if menuDictionary[key] == nil {
                menuDictionary[key] = nil
            }
            menuDictionary[key] = menuItem
        }
        return menuDictionary
    }
}











//struct MenuData {
//
//    enum  MenuIcons: String, CaseIterable {
//        case miaLearnsLogo, miABCQuizLogo, miaTalksLogo, learnWLukeLogo, findMeLogo, storyTimeLogo, lukeTalksLogo
//    }
//
//    enum MenuLessonAge: String, CaseIterable {
//        case two = "Age: 2+"
//        case three = "Age: 3+"
//        case four = "Age: 4+"
//        case five = "Age: 5+"
//    }
//
//    enum MenuDisplayNames: String, CaseIterable {
//        case Mia_learns, Mia_abc_quiz, Mia_talks, Learn_with_Luke, Find_me, Story_time, Luke_talks
//    }
//
//    func getMenuData() {
//        let menuIcons = MenuIcons.allCases.map { $0.rawValue }
//        let menuNames = MenuDisplayNames.allCases.map { $0.rawValue.replacingOccurrences(of: "_", with: " ")}
//    }
//
//    let MenuDataDict: [String: MenuItem] = [
//        MenuIcons.miaLearnsLogo.rawValue: MenuItem(imageName: MenuIcons.miaLearnsLogo.rawValue, displayName: MenuDisplayNames.Mia_learns.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.two.rawValue),
//
//        MenuIcons.miABCQuizLogo.rawValue: MenuItem(imageName: MenuIcons.miABCQuizLogo.rawValue, displayName: MenuDisplayNames.Mia_abc_quiz.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.three.rawValue),
//
//        MenuIcons.miaTalksLogo.rawValue: MenuItem(imageName: MenuIcons.miaTalksLogo.rawValue, displayName: MenuDisplayNames.Mia_talks.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.three.rawValue),
//
//        MenuIcons.learnWLukeLogo.rawValue: MenuItem(imageName: MenuIcons.learnWLukeLogo.rawValue, displayName: MenuDisplayNames.Learn_with_Luke.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.five.rawValue),
//
//        MenuIcons.findMeLogo.rawValue: MenuItem(imageName: MenuIcons.findMeLogo.rawValue, displayName: MenuDisplayNames.Find_me.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.three.rawValue),
//
//        MenuIcons.storyTimeLogo.rawValue: MenuItem(imageName: MenuIcons.storyTimeLogo.rawValue, displayName: MenuDisplayNames.Story_time.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.two.rawValue),
//
//        MenuIcons.lukeTalksLogo.rawValue: MenuItem(imageName: MenuIcons.lukeTalksLogo.rawValue, displayName: MenuDisplayNames.Luke_talks.rawValue.replacingOccurrences(of: "_", with: " "), age: MenuLessonAge.four.rawValue)
//    ]
//}

