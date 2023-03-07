//
//  LearnWithLukeDetailData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/6/23.
//

import Foundation

//All in LearnWLukeData

struct LearnWithLukeDetailData {
    
    var items: [String] = [] //Initial Snapshot
    var buttonMedia: [String: String] = [:]
    
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
}
