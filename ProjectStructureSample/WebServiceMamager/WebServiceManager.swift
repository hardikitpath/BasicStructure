//
//  WebServiceManager.swift
//  ChatApp
//
//  Created by Hardik Modha on 26/01/20.
//  Copyright © 2020 Hardik Modha. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

public class WebserviceManager {
    
    private init() {}
    
    // MARK: - Singleton
    static var shared: WebserviceManager {
        return WebserviceManager()
    }
    
    static var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    lazy var session: Session = {
        let configure = URLSessionConfiguration.ephemeral
        
        configure.httpCookieStorage = nil
        configure.httpCookieAcceptPolicy = .never
        configure.httpShouldSetCookies = false
        
        let session = Session(configuration: configure)
        return session
    }()
    
    
    
    public func fetch<A>(resource: WebResource<A>, completion: @escaping ResultHandler<A>) -> RequestToken? {
        
        guard let url = resource.urlPath.url else {
            assertionFailure("Provide vaild url")
            return nil
        }
        var headers: HTTPHeaders?
        let paramater = resource.httpMethod.parameter
        let method = resource.httpMethod.method
        let encoding = resource.httpMethod.encoding
        
        if let header = resource.header {
            headers = HTTPHeaders(header)
        }
        
        let dataTask  = self.session.request(url, method: method, parameters: paramater, encoding: encoding, headers: headers, interceptor: nil).responseData { (response) in
            
            self.processResponse(response: response, decode: resource.decode, completion: completion)
            
        }
        
        return RequestToken(task: dataTask)
    }
    
    func processResponse<A>(response: AFDataResponse<Data>, decode: (Data) -> Result<A>, completion: @escaping ResultHandler<A>) {
        
        if let error  = response.error {
            
            switch error._code {
            case NSURLErrorTimedOut:
                completion(.failure(.timeOut))
                return
            case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                completion(.failure(.noInternet))
                return
            case NSURLErrorCancelled:
                completion(.failure(.requestCancelled))
                return
            default:
                print(error)
                break // this will ask runtime to move forward, to continue execution of below code
            }
        }
        
        guard let httpResponse = response.response else {
            completion(.failure(.noInternet))
            return
        }
        
        switch httpResponse.statusCode {
        case 401:
            completion(.failure(.sessionExpired401))
            break
        case 200:
            switch response.result {
            case .success(let data):
                completion(decode(data))
            case .failure(_):
                completion(.failure(.internalServerError))
            }
        case 400:
            completion(.failure(.error400))
        default:
            break
        }
    }
    
    // MARK:- Post API
    func postResource<A>(_ resource: WebResource<A>, progressCompletion: ((Double)->Void)?, completion: @escaping (Result<A>)->Void)  {
        guard let url = resource.urlPath.url else {
            completion(.failure(.unExpectedValue))
            return
        }
        guard WebserviceManager.isReachable else {
            completion(.failure(.noInternet))
            return
        }
        
        let parameter = resource.httpMethod.parameter
        let header = HTTPHeaders(resource.header ?? [:])
        let method = resource.httpMethod.method
        let prepareFormData: (MultipartFormData)->Void = { (multipartFormData) in
            guard let parameters = parameter else { return }
            
            for (key, value) in parameters {
                let (url, mimeType) = MediaType.generateMimeType(key: key, value: value)
                if let url = url {
                    multipartFormData.append(url, withName: key, fileName: url.fileNameWithExtension, mimeType: mimeType)
                }
                else if
                    let stringValue = value as? String,
                    let data = stringValue.data(using: String.Encoding.utf8) {
                    multipartFormData.append(data, withName: key)//, mimeType: "text/plain")
                }
                else if
                    let bool = value as? Bool,
                    let data = String(bool).data(using: String.Encoding.utf8) {
                    multipartFormData.append(data, withName: key)//, mimeType: "text/plain")
                }
                else if let int = value as? NSNumber {
                    let data = int.stringValue.data(using: String.Encoding.utf8)
                    multipartFormData.append(data!, withName: key)//, mimeType: "text/plain")
                } else if let data = value as? [URL] {
                    for value in data {
                        let (url, mimeType) = MediaType.generateMimeType(key: key, value: value)
                        if let url = url {
                            multipartFormData.append(url, withName: key, fileName: url.fileNameWithExtension, mimeType: mimeType)
                        }
                    }
                } else if let data = value as? [UIImage] {
                    for image in data {
                        let imagData = image.jpegData(compressionQuality: 0.5)!
                        let name = "image\(Date().timeIntervalSince1970).jpg"
                    
                        multipartFormData.append(imagData, withName: key, fileName: name, mimeType: "image/jpg")
                    }
                } else {
                    print("Unable to add form data for key: '\(key)'.")
                }
            }
        }
        
        self.session.upload(multipartFormData: prepareFormData, to: url, method: method, headers: header)
            .uploadProgress(closure: { (progress) in
                progressCompletion?(progress.fractionCompleted)
            })
            
            .downloadProgress(closure: { (progress) in
                progressCompletion?(progress.fractionCompleted)
            })
            
            .responseData(completionHandler: { (response) in
                self.processResponse(response: response, decode: resource.decode, completion: completion)
            })
            
            .responseJSON { (response) in
                print("Response in JSON: \(response)")
            }
    }
    
}


    
    
