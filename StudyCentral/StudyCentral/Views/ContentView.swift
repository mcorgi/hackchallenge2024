//
//  ContentView.swift
//  HackChallenge
//
//  Created by Ruby P on 11/30/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties (data)
    @State private var classList: [ClassItem] = []
    // Dummy Data
    let class2 = ClassItem(
            name: "CS 3110 - Data Structures and Functional Programming",
            description: "Advanced programming course that emphasizes functional programming techniques and data structures. Programming topics include recursive and higher-order procedures, models of programming language evaluation and compilation, type systems, and polymorphism. Data structures and algorithms covered include graph algorithms, balanced trees, memory heaps, and garbage collection. Also covers techniques for analyzing program performance and correctness.",
            schedule: "MWF 11:15 AM - 12:05 PM",
            prerequisites: ["CS 1110", "CS 2110"], prelims: [])
    let class3 = ClassItem(
            name: "CS 3410 - Computer System Organization and Programming",
            description: "Introduction to computer organization, systems programming and the hardware/ software interface. Topics include instruction sets, computer arithmetic, datapath design, data formats, addressing modes, memory hierarchies including caches and virtual memory, I/O devices, bus-based I/O systems, and multicore architectures. Students learn assembly language programming and design a pipelined RISC processor.",
            schedule: "TR 9:40 AM - 10:55 AM",
            prerequisites: ["CS 2110"], prelims: [])
    let class4 = ClassItem(
            name: "ECE 2720 - Data Science for Engineers",
            description: "An introduction to data science for engineers. The data science workflow: acquisition and cleansing, exploration and modeling, prediction and decision making, visualization and presentation. Tools for data science including numerical optimization, the Discrete Fourier Transform, Principal Component Analysis, and probability with a focus on statistical inference and correlation methods. Techniques for different steps in the workflow including outlier detection, filtering, regression, classification, and techniques for avoiding overfitting. Methods for combining domain-agnostic data analysis tools with the types of domain-specific knowledge that are common in engineering. Ethical considerations. Optional topics include classification via neural networks, outlier detection, and Markov chains. Programming projects in Python.",
            schedule: "MW 2:55 PM - 4:10 PM",
            prerequisites: ["MATH 1920", "CS 1110/1112", "MATH 2940"], prelims: [])
    let class5 = ClassItem(
            name: "CS 4820 - Algorithms",
            description: "Develops techniques used in the design and analysis of algorithms, with an emphasis on problems arising in computing applications. Example applications are drawn from systems and networks, artificial intelligence, computer vision, data mining, and computational biology. This course covers four major algorithm design techniques (greedy algorithms, divide-and-conquer, dynamic programming, and network flow), undecidability and NP-completeness, and algorithmic techniques for intractable problems (including identification of structured special cases , approximation algorithms, local search heuristics, and online algorithms).",
            schedule: "MWF 9:05 AM - 9:55 AM",
            prerequisites: ["CS 3110", "CS 2800"], prelims: [])
    let class6 = ClassItem(
            name: "CS 4410 - Operating Systems",
            description: "Introduction to the design of systems programs, with emphasis on multiprogrammed operating systems. Topics include concurrency, synchronization, deadlocks, memory management, protection, input-output methods, networking, file systems and security. The impact of network and distributed computing environments on operating systems is also discussed.",
            schedule: "TR 9:40 AM - 10:55 AM",
            prerequisites: ["CS 3410/3420"], prelims: []
        )
    let class7 = ClassItem(
            name: "CS 4760 - Introduction to Computer Vision",
            description: "An in-depth introduction to computer vision. The goal of computer vision is to compute properties of our world-the 3D shape of an environment, the motion of objects, the names of people or things-through analysis of digital images or videos.  The course covers a range of topics, including 3D reconstruction, image segmentation, object recognition, and vision algorithms fro the Internet, as well as key algorithmic, optimization, and machine learning techniques, such as graph cuts, non-linear least squares, and deep learning.  This course emphasizes hands-on experience with computer vision, and several large programming projects.",
            schedule: "MWF 1:30 PM - 2:20 PM",
            prerequisites: ["CS 2110", "CS 2800"], prelims: [])
    @State private var searchQuery: String = ""
    var filteredClasses: [ClassItem] {
        classList.filter { searchQuery.isEmpty || $0.name.localizedCaseInsensitiveContains(searchQuery) }
    }
    
    //MARK: - Networking
    private func fetchClasses () {
        NetworkManager.shared.fetchClasses ( completion: { /*[weak self]*/ classes in
            /*guard let self else { return }*/
            self.classList = classes
            classList.append(class2)
            classList.append(class3)
            classList.append(class4)
            classList.append(class5)
            classList.append(class6)
            classList.append(class7)
        })
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
            .onAppear {
                fetchClasses()
            }
            .navigationBarTitle("📚 STUDY CENTRAL 📚", displayMode: .inline)
        }
    }
}
