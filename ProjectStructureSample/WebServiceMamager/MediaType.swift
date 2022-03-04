//
//  MediaType.swift
//  ChatApp
//
//  Created by Hardik Modha on 20/04/20.
//  Copyright © 2020 Hardik Modha. All rights reserved.
//

import Foundation


extension URL {
    
    var fileName: String {
        return self.deletingPathExtension().lastPathComponent
    }
    
    var fileExtension: String {
        return self.pathExtension
    }
    
    var fileNameWithExtension: String {
        return fileName + " " + fileExtension
    }
}

enum MediaType: String {
    case jpg
    case png
    case doc
    case jpeg
}

extension MediaType {
    
    var mimeType: String {
        switch self {
        case .png:
            return "image/png"
        case .jpg, .jpeg:
            return "image/jpeg"
        case .doc:
            return "application/msword"
        }
        
    }
}

extension MediaType {
    
   static func generateMimeType(key: String, value: Any) -> (url: URL?, mimeType: String) {
        if let url = value as? URL {
            
            guard let mediaType = MediaType(rawValue: url.pathExtension.lowercased()) else {
                return (nil, "")
            }
            
            return (value as? URL, mediaType.mimeType)
            
        }
        return (nil, "")
    }
}
