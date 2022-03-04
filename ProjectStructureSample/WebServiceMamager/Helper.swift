//
//  Helper.swift
//  WebCluesPracticle
//
//  Created by Hardik Modha on 21/07/20.
//  Copyright © 2020 Hardik Modha. All rights reserved.
//

import Foundation

public typealias JSONType = [String: Any]
public typealias Header = [String: String]
public typealias ResultHandler<A> = (Result<A>) -> Void
public typealias EmptyHandler = () -> Void
public typealias Progress = (Double) -> Void
public typealias CofirmationHandler = (Bool) -> Void
public typealias ResponseStatusHandler = (Bool, String) 


