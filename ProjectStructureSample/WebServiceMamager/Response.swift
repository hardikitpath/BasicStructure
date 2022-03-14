//
//  File.swift
//  
//
//  Created by Hardik Modha on 07/03/21.
//

import Foundation

 struct Response<A: Codable>: Codable {
    var status: String?
    var message: String?
    var data: A?
}
