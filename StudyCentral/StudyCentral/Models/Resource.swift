//
//  Resource.swift
//  StudyCentral
//
//  Created by Samantha Ahn on 12/5/24.
//

import Foundation

struct Resource: Identifiable, Codable {
    let id = UUID()
    let name: String
    let link: String
}
