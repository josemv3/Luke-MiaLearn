//
//  MenuData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/5/23.
//

import Foundation

struct MenuData {

    enum MenuIcons: String, CaseIterable, Hashable {
        case miaLearnsLogo = "Mia learns",
             miABCQuizLogo = "Mia abc quiz",
             miaTalksLogo = "Mia talks",
             learnWLukeLogo = "Learn with luke",
             findMeLogo = "Find me",
             storyTimeLogo = "Story time",
             lukeTalksLogo = "Luke talks"
        
        var imageName: String {
            return "\(self)" //case as string
        }
        
        var displayName: String {
            return self.rawValue 
        }
        
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

}


//var menuDataFinal: [String: MenuItem] = [:]
//var snapShotItems = MenuIcons.allCases.map { "\($0)" }

//    struct MenuItem {
//        let imageName: String
//        let displayName: String
//        let age: String
//    }dw

//    struct MenuItem {
//        let menuIcon: MenuIcons
//        let age: String
//        var imageName: String {
//            menuIcon.imageName
//        }
//        var displayName: String {
//            menuIcon.displayName
//        }
//    }


//    func buildMenuDictionary() -> [String: MenuItem] {
//        var menuDictionary: [String: MenuItem] = [:]
//        //loop through MenuIcon cases
//        for menuIcon in MenuIcons.allCases {
//            let displayName = menuIcon.displayName
//            let age = menuIcon.age //using case to grab age
//            let imageName = menuIcon.imageName
//            let menuItem = MenuItem(menuIcon: menuIcon, age: menuIcon.age)
//            let key = "\(menuIcon)" //Make enum case a string (not the associated value)
//            if menuDictionary[key] == nil {
//                menuDictionary[key] = nil
//            }
//            menuDictionary[key] = menuItem
//        }
//        return menuDictionary
//    }






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

