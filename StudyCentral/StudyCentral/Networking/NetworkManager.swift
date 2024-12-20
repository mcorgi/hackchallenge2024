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
    private let devEndpoint: String = "http://34.48.134.152" //add later when I get endpoint from Backend members
    
    let decoder = JSONDecoder()

    // MARK: - Requests
    func fetchClasses (completion: @escaping([ClassItem]) -> Void) {
        //make decoder
        let newEndpoint = devEndpoint + "/api/courses/"

        AF.request(newEndpoint, method: .get)
            .validate()
            .responseDecodable(of: [String: [ClassItem]].self, decoder: decoder) { response in
                switch response.result {
                case .success(let classesDictionary):
                    if let classes = classesDictionary["courses"] {
                        print("Successfully got \(classes.count) Classes")
                        completion(classes)
                    } else {
                        print("Key not found")
                        completion([])
                    }
//                    print ("Successfully got \(classes.count) Classes")
//                    completion(classes)
                case .failure(let error):
                    print ("Error in NetworkingManager.fetchClasses", error)
                }
            }
    }
    
    func fetchPrelims (completion: @escaping([Prelim]) -> Void) {
        //make decoder
        let newEndpoint = devEndpoint + "/api/prelims/"

        AF.request(newEndpoint, method: .get)
            .validate()
            .responseDecodable(of: [String: [Prelim]].self, decoder: decoder) { response in
                switch response.result {
                case .success(let prelimDictionary):
                    if let prelims = prelimDictionary["prelims"] {
                        print("Successfully got \(prelims.count) Prelims")
                        var temp = 0
                        for r in prelims {
                            for c in r.topics {
                                temp += 1
                            }
                        }
                        print("Successfully got \(temp) Resources")
                        completion(prelims)
                    } else {
                        print("Key not found")
                        completion([])
                    }
//                    print ("Successfully got \(classes.count) Classes")
//                    completion(classes)
                case .failure(let error):
                    print ("Error in NetworkingManager.fetchPrelims", error)
                }
            }
    }
    
//    func fetchResources (completion: @escaping([Resource]) -> Void) {
//        //make decoder
//        let newEndpoint = devEndpoint + "/api/topics/"
//
//        AF.request(newEndpoint, method: .get)
//            .validate()
//            .responseDecodable(of: [Resource].self, decoder: decoder) { response in
//                switch response.result {
//                case .success(let resources):
//                    print ("Successfully got \(resources.count) Resources")
//                    completion(resources)
//                case .failure(let error):
//                    print ("Error in NetworkingManager.fetchClasses", error)
//                }
//            }
//    }

    func addResource (link: String, topic: String, identify: String, completion: @escaping ((Resource)-> Void)) {
        let newEndpoint = devEndpoint + "/api/topics/"
        let parameters: Parameters = [
            "resource_link": link,
            "name": topic,
            "prelim_id": identify
        ]
        
        AF.request (newEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Resource.self, decoder: decoder) { response in
                switch response.result {
                case .success(let resource):
                    print ("Successfully added resource")
                    completion (resource)
                case .failure(let error):
                    print ("Error in NetworkingManager.addResource: \(error.localizedDescription)")
                }
            }
    }
}
