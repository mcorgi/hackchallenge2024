//
//  Prelim.swift
//  StudyCentral
//
//  Created by Samantha Ahn on 12/6/24.
//

import Foundation

struct Prelim: Identifiable, Codable {
    let id = UUID()
    let name: String
    let prelimId: Int
}
