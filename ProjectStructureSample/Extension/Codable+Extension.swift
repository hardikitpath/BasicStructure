//
//  Codable+Extension.swift
//  TwilloChatDemo
//
//  Created by macbook pro on 04/05/20.
//  Copyright © 2020 macbook pro. All rights reserved.
//

import Foundation


public extension Decodable {
    static func decode<A: Codable>(_ data: Data) -> Result<A> {
            
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(A.self, from: data)
            return .success(result)
        } catch  {
            print(error.localizedDescription)
            return .failure(.unExpectedValue)
        }
    
    }
}

public extension Encodable {
    var jsonEncoded: JSONType? {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: encodedData, options: JSONSerialization.ReadingOptions.mutableContainers)
            return (jsonObject as? JSONType)
        } catch {
            print("Error while encoding \(self): \(error)")
            return nil
        }
    }
}
