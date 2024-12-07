//
//  Prelim.swift
//  StudyCentral
//
//  Created by Samantha Ahn on 12/6/24.
//

import Foundation

struct Prelim: Identifiable, Codable {
    let id = UUID()
//    let prelimId: Int
    let date = Date()
//    let course_id: Int
    let title: String
    let topics: [Resource]
}
