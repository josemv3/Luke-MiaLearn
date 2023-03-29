//
//  MiaTalksData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/5/23.
//

import Foundation

struct MiaTalksItem: Hashable {
    let rawValue: String
}
    
struct MiaTalksData {
    
    enum ILike: String, CaseIterable, Hashable {
        case apples, hamburger, carrot, broccoli, cereal, bananas
    }

    enum IWant: String, CaseIterable, Hashable {
        case bandaid, toy, food, shake, orange, sandwich
    }

    enum CurrentLesson: CaseIterable {
        case iLike, iWant
        
        var lessons: [MiaTalksItem] {
            switch self {
            case .iLike:
                return ILike.allCases.map { MiaTalksItem(rawValue: $0.rawValue) }
            case .iWant:
                return IWant.allCases.map { MiaTalksItem(rawValue: $0.rawValue) }
            }
        }
    }
}





//    mutating func makeLessonSet<T: CaseIterable>(valueSet: T.Type) -> [String: String] where T.AllCases.Element: RawRepresentable, T.AllCases.Element.RawValue == String {
//
//        lessonItems = Letters.allCases.map { $0.rawValue }
//        let valueSet = valueSet.allCases.map { $0.rawValue }
//        return Dictionary(uniqueKeysWithValues: zip(lessonItems, valueSet))
//    }
