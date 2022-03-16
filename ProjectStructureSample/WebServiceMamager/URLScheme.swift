//
//  URLScheme.swift
//  ChatApp
//
//  Created by Hardik Modha on 19/01/20.
//  Copyright © 2020 Hardik Modha. All rights reserved.
//

import Foundation

//http://dummy.restapiexample.com/api/v1/create

public enum URLScheme: String {
    case http
    case https
}
//  https://jsonplaceholder.typicode.com/users

public enum URLHost {
    case production
    case developement
    case staging
    
    var baseURL: String {
        switch self {
        case .developement:
            return "dummy.restapiexample.com"
        case .production:
            return "jsonplaceholder.typicode.com"
        case .staging:
            return ""
        }
    }
    
    var scheme: URLScheme {
        switch self {
        case .developement:
            return .http
        case .production, .staging:
            return .https
        
        }
    }
    
    var fixedPath: String {
        switch self {
        case .developement:
            return "/api/v1/"
        case .staging, .production:
            return "/"
        }
    }
}

public enum URLPath {
    case users
    case posts(Int)
    case createEmployee
    case getEmployees
    
    var endPoint: String {
        switch self {
        case .users:
            return "users"
        case .posts:
            return "posts"
        case .createEmployee:
            return "create"
        case .getEmployees:
            return "employees"
        }
    }
    
    var queryItem: [URLQueryItem]? {
       return nil
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
