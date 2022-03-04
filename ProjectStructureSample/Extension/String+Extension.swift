//
//  String+Extension.swift
//  WebCluesPracticle
//
//  Created by macbook pro on 21/07/20.
//  Copyright © 2020 macbook pro. All rights reserved.
//

import Foundation

public extension String {
    
    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)

    }
}
