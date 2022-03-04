//
//  WebResource.swift
//  ChatApp
//
//  Created by Hardik Modha on 26/01/20.
//  Copyright © 2020 Hardik Modha. All rights reserved.
//

import Foundation
import Alamofire

public enum HTTPMethod {
    case get
    case post(JSONType)
    case put(JSONType)
    
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return Alamofire.HTTPMethod.get
        case .post(_):
            return Alamofire.HTTPMethod.post
        case .put(_):
            return Alamofire.HTTPMethod.put
        }
    }
    
    var parameter: JSONType? {
        switch self {
        case .post(let parameter):
            return parameter
        case .put(let parameter):
            return parameter
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .get:
            return JSONEncoding.default
        case .put(_), .post(_):
            return URLEncoding.default
        }
    }
}

public class RequestToken {
    let task: DataRequest
    
    init(task: DataRequest) {
        self.task = task
    }
    
    func cancel() {
        self.task.cancel()
    }
}


public struct WebResource<A> {
    var urlPath: URLPath
    var httpMethod: HTTPMethod = .get
    var header: Header?
    var decode: (Data) -> Result<A>
    
    public init(urlPath: URLPath, httpMethod: HTTPMethod, header: Header?, decode: @escaping (Data) -> Result<A>) {
        self.urlPath = urlPath
        self.httpMethod = httpMethod
        self.header = header
        self.decode = decode
    }
    
    @discardableResult
    public func request(completion: @escaping ResultHandler<A>)  -> RequestToken? {
        return WebserviceManager.shared.fetch(resource: self, completion: completion)
    }
    
    public func uploadRequest(progress: Progress?, completion: @escaping ResultHandler<A> )  {
        WebserviceManager.shared.postResource(self, progressCompletion: progress, completion: completion)
    }
    
    
}




