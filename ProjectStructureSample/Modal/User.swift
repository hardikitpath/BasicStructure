//
//  User.swift
//  ProjectStructureSample
//
//  Created by  MAC OS 19 on 19/11/1400 AP.
//

import Foundation


// MARK: - Welcome
struct User: Codable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
}

extension User {
    
    static func getUsers(completion: @escaping ResultHandler<[User]>) {
        
        let webResource = WebResource<[User]>(urlPath: .users, httpMethod: .get, header: nil, decode: User.decode)
        
        webResource.request { result in
            completion(result)
        }
        
    }
}

// MARK: - Address
struct Address: Codable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    var name, catchPhrase, bs: String?
}
