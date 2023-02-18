//
//  CaseIterable.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/17/23.
//

import Foundation

extension CaseIterable where Self: RawRepresentable {
    static var allRawValues: [RawValue] {
    return allCases.map({ $0.rawValue })
    }
}
