//
//  ClassCellView.swift
//  HackChallenge
//
//  Created by Ruby P on 11/30/24.
//

import SwiftUI

struct ClassCellView: View {
    let classItem: ClassItem
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(classItem.name)
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            Text(classItem.schedule)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(width: 300, height: 120)
        .background(Color.blue.opacity(0.3))
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}
