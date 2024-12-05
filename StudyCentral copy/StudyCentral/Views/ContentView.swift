//
//  ContentView.swift
//  HackChallenge
//
//  Created by Ruby P on 11/30/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties (data)
    
    @State private var searchQuery: String = ""
    var filteredClasses: [ClassItem] {
        sampleClasses.filter { searchQuery.isEmpty || $0.name.localizedCaseInsensitiveContains(searchQuery) }
    }
    
    
    // MARK: - Main View
    
    var body: some View {
        NavigationView {
            ZStack {
                
                // Background Aesthetics
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Search Bar
                    TextField("Search Classes...", text: $searchQuery)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // Scroll View for List of [ClassCellView]
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filteredClasses) { classItem in
                                NavigationLink(destination: ViewController(classItem: classItem)) {
                                    ClassCellView(classItem: classItem)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarTitle("📚 STUDY CENTRAL 📚", displayMode: .inline)
        }
    }
}
