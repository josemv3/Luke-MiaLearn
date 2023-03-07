//
//  LearnWLukeData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/5/23.
//

import Foundation

struct LearnWLukeData {
    
    //LukeView list items
    var lessonItems: [String] = []
    var initialLetters = [Character]() //Initial Snapshot (sections)
    var itemsByInitialLetter = [Character: [String]]() //Initial Snapshot.appendItems
   
    //DetailView
    var items: [String] = [] //Initial Snapshot
    var buttonMedia: [String: String] = [:]
    var mediaNames: [String: String] = [:] //video names and images for mainView
    
    //LukeView - Lesson Items
    enum Space: String, CaseIterable {
        case Sun, Venus, Mercury, Earth, Earths_moon,
             Mars, NASA, Jupiter, Saturn, Uranus,
             Neptune, Asteroid_belt, Comets, Astronaut, Shuttle,
             Satelite, Rocket, Solar_System, Pluto, Black_Hole
    }

    mutating func getLesson<T: CaseIterable>(lesson: T.Type) where T.AllCases.Element: RawRepresentable, T.AllCases.Element.RawValue == String {
        lessonItems = lesson.allCases.map { $0.rawValue.replacingOccurrences(of: "_", with: " ") }
    }
    
    //DetailView
    enum Item: String, CaseIterable {
        case a,b,c,d
    }
    
    enum ImageName: String, CaseIterable {
        case lwl1, lwl2, lwl3, lwl4
    }
    
   private mutating func getItems() {
        items = Item.allCases.map { $0.rawValue }
    }
    
    mutating func getButtonMedia() {
        getItems()
        let images = ImageName.allCases.map { $0.rawValue }
        buttonMedia = zip(items, images).reduce(into: [:], { $0[$1.0] = $1.1})
    }
    
    mutating func getMediaNames(category: String) {
        guard let enumValue = Space(rawValue: category.replacingOccurrences(of: " ", with: "_")) else {
            print("Error")// Handle unknown category values
            return
        }
        let media = (1...4).map { "\(enumValue.rawValue)\($0)".replacingOccurrences(of: "_", with: "") }
        mediaNames = zip(items, media).reduce(into: [:]) { $0[$1.0] = $1.1 }
    }
}





//    mutating func getMediaNames(category: String) {
//        mediaNames = (1...4).map { "\(Space.Sun.rawValue)\($0)" }
//    }
