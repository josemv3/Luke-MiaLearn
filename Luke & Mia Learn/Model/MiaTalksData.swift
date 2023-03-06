//
//  MiaTalksData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/5/23.
//

import Foundation

struct MiaTalksData {
    
    var lessonItems: [String] = []
    var lessonSet: [String: String] = [:]
    
    enum Letters: String, CaseIterable {
        case a,b,c,d,e,f
    }
    
    enum ILike: String, CaseIterable {
        case apples, hamburger, carrot, broccoli, cereal, bananas
    }
    
    mutating func makeLessonSet<T: CaseIterable>(valueSet: T.Type) -> [String: String] where T.AllCases.Element: RawRepresentable, T.AllCases.Element.RawValue == String {
    
        lessonItems = Letters.allCases.map { $0.rawValue }
        let valueSet = valueSet.allCases.map { $0.rawValue }
        return Dictionary(uniqueKeysWithValues: zip(lessonItems, valueSet))
    }
    
}
