//
//  URLScheme.swift
//  ChatApp
//
//  Created by Hardik Modha on 19/01/20.
//  Copyright © 2020 Hardik Modha. All rights reserved.
//

import Foundation

public enum URLScheme: String {
    case http
    case https
}
//  https://jsonplaceholder.typicode.com/users

public enum URLHost {
    case live
    case local
    case staging
    
    var baseURL: String {
       return "jsonplaceholder.typicode.com"
    }
    
    var scheme: URLScheme {
        switch self {
        case .local:
            return .http
        case .live, .staging:
            return .https
        
        }
    }
    
    var fixedPath: String {
        return "/"
    }
}

public enum URLPath {
    case users
    case posts(Int)
    
    var endPoint: String {
        switch self {
        case .users:
            return "users"
        case .posts:
            return "posts"
        }
    }
    
    var queryItem: [URLQueryItem]? {
        switch self {
        case .users:
            return nil
        case .posts(let id):
            return [URLQueryItem(name: "userId", value: String(id))]
        }
    }
    
    
    var url: URL? {
        var urlComponets = URLComponents()
        urlComponets.scheme = AppConfig.host.scheme.rawValue
        urlComponets.host = AppConfig.host.baseURL
        urlComponets.queryItems = self.queryItem
        urlComponets.path = AppConfig.host.fixedPath + self.endPoint
        return urlComponets.url
    }
}
