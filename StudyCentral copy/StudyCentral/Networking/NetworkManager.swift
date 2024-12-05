//
//  NetworkManager.swift
//  HackChallenge2024
//
//  Created by Samantha Ahn on 11/30/24.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    private init() {
        decoder.dateDecodingStrategy = .iso8601
        //convert to camelcase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    private let devEndpoint: String = "" //add later when I get endpoint from Backend members
    
    let decoder = JSONDecoder()

    // MARK: - Requests
    func fetchClasses (completion: @escaping([ClassItem]) -> Void) {
        //make decoder
        let newEndpoint = devEndpoint + ""

        AF.request(newEndpoint, method: .get)
            .validate()
            .responseDecodable(of: [ClassItem].self, decoder: decoder) { response in
                switch response.result {
                case .success(let classes):
                    print ("Successfully got \(classes.count) Classes")
                    completion(classes)
                case .failure(let error):
                    print ("Error in NetworkingManager.fetchClasses", error)
                }
            }
    }

    func addResource (link: String, topic: String, completion: @escaping ((ClassItem)-> Void)) {
        let newEndpoint = devEndpoint + ""
        let parameters: Parameters = [
            "link": link,
            "topic": topic
        ]
        
        AF.request (newEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: ClassItem.self, decoder: decoder) { response in
                switch response.result {
                case .success(let classItem):
                    print ("Successfully added resource")
                    completion (classItem)
                case .failure(let error):
                    print ("Error in NetworkingManager.addResource: \(error.localizedDescription)")
                }
            }
    }
}
