//
//  ViewController.swift
//  HackChallenge
//
//  Created by Ruby P on 11/30/24.
//

import SwiftUI

struct ViewController: View {
    
    // MARK: - Properties (Data)
    let classItem: ClassItem
    @State private var expandedTopic: String?
    @State private var selectedPrelim: String = "First Prelim"
    @State private var newResourceLink: String = ""
    @State private var newResourceTopic: String = ""
    
    @State private var fstPrelimResources: [(link: String, topic: String)] = [("https://youtu.be/rbbTd-gkajw?si=kRUTl9Yvcqo3zifi", "Sorting Algorithms")]
    @State private var sndPrelimResources: [(link: String, topic: String)] = [("https://youtu.be/aPQY__2H3tE?si=tnhvb-yypdCnfTmq", "Dynamic Programming")]
    @State private var finalPrelimResources: [(link: String, topic: String)] = [("https://youtu.be/Tl90tNtKvxs?si=rNdE7f1M-VV7QBGh", "Ford-Fulkerson Algorithm")]

    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Background Aesthetics
            LinearGradient(
                gradient: Gradient(colors: [Color.mint.opacity(0.8), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            // MARK: - Content ScrollView
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Prerequisite Classes Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Prerequisite Classes")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(classItem.prerequisites, id: \.self) { prerequisite in
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color.white)
                                        Text(prerequisite)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    .padding()
                                    .background(Color.green.opacity(0.8))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 100)
                    }

                    Divider().background(Color.black)

                    // MARK: - Schedule and Description Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Schedule")
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(classItem.schedule)
                            .font(.body)
                            .foregroundColor(.black.opacity(0.9))
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(classItem.description)
                            .font(.body)
                            .foregroundColor(.black.opacity(0.9))
                    }
                    .padding(.horizontal)

                    Divider().background(Color.black)

                    // MARK: - Prelim Resources Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Prelim Resources")
                            .font(.headline)
                            .foregroundColor(.black)

                        // MARK: First Prelim Section
                        ResourceSectionWithTopics(
                            title: "First Prelim",
                            resources: $fstPrelimResources,
                            expandedTopic: $expandedTopic
                        )
                        .background(.yellow.opacity(0.2))

                        // MARK: Second Prelim Section
                        ResourceSectionWithTopics(
                            title: "Second Prelim",
                            resources: $sndPrelimResources,
                            expandedTopic: $expandedTopic
                        )
                        .background(.orange.opacity(0.2))

                        // MARK: Final Prelim Section
                        ResourceSectionWithTopics(
                            title: "Final Prelim",
                            resources: $finalPrelimResources,
                            expandedTopic: $expandedTopic
                        )
                        .background(.pink.opacity(0.2))

                        // MARK: Interactive Resource Addition Section
                        VStack(alignment: .leading) {
                            Text("Add a New Resource")
                                .font(.headline)
                                .foregroundColor(.black)

                            TextField("Enter topic for this link", text: $newResourceTopic)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 8)
                            
                            TextField("Enter resource link", text: $newResourceLink)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom, 8)

                            Picker("Select Prelim", selection: $selectedPrelim) {
                                Text("First Prelim").tag("First Prelim")
                                Text("Second Prelim").tag("Second Prelim")
                                Text("Final Prelim").tag("Final Prelim")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.purple.opacity(0.4))
                            .padding(.bottom, 8)

                            Button(action: addResource) {
                                Text("Add Resource")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(Color.indigo.opacity(0.3))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal)

                    Divider().background(Color.black)
                }
            }
        }
    }

    // MARK: - Add Resource
    private func addResource() {
        guard !newResourceLink.isEmpty, !newResourceTopic.isEmpty else { return }

        let newResource = (link: newResourceLink, topic: newResourceTopic)

        switch selectedPrelim {
        case "First Prelim":
            fstPrelimResources.append(newResource)
        case "Second Prelim":
            sndPrelimResources.append(newResource)
        case "Final Prelim":
            finalPrelimResources.append(newResource)
        default:
            break
        }

        newResourceLink = ""
        newResourceTopic = ""
    }
}

// MARK: - Functionality for Resource Section With Topics
struct ResourceSectionWithTopics: View {
    let title: String
    @Binding var resources: [(link: String, topic: String)]
    @Binding var expandedTopic: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(resources, id: \.topic) { resource in
                        Button(action: {
                            expandedTopic = (expandedTopic == resource.topic) ? nil : resource.topic
                        }) {
                            Text(resource.topic)
                                .padding()
                                .background(Color.gray.opacity(0.7))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
            }

            if let topic = expandedTopic {
                ForEach(resources.filter { $0.topic == topic }, id: \.link) { resource in
                    VStack(alignment: .leading) {
                        Text(resource.link)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
