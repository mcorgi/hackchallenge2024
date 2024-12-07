//
//  ClassItem.swift
//  HackChallenge
//
//  Created by Ruby P on 11/30/24.
//

import Foundation

struct ClassItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let schedule: String
    let prerequisites: [String]
    let prelims: [Prelim]
}
