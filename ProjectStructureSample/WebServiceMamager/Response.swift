//
//  File.swift
//  
//
//  Created by Hardik Modha on 07/03/21.
//

import Foundation

public struct Response<A: Codable>: Codable {
    var status: Int?
    var message: String?
    var data: A?
}
