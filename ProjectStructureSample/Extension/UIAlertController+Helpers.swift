//
//  UIAlertController+Helpers.swift
//  HomeOpenReferralPhone
//
//  Created by Ekta on 13/08/18.
//  Copyright © 2018 Technobrave Pty Ltd. All rights reserved.
//

import UIKit
public extension UIAlertController {
    
    func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(alertAction)
    }
    
    class func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler)
        return alertAction
       
    }
    
    class func alert(title: String?, message: String? = nil, style: UIAlertController.Style = .alert, action: UIAlertAction? = nil, cancelAction: UIAlertAction? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let cancel = cancelAction {
            alertController.addAction(cancel)
        } else {
            alertController.addAction(title: "OK", style: .cancel)
        }
        
        if let actionUnwrapped = action {
            alertController.addAction(actionUnwrapped)
        }
        
        return alertController
    }
    
    class func alert(title: String, message: String? = nil, confirmationHandler: @escaping ((Bool)-> Void)) -> UIAlertController {
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { _ in
            confirmationHandler(false)
        }
        
        let alert = UIAlertController.alert(title: title, message: message, cancelAction: cancelAction)
        alert.addAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            confirmationHandler(true)
        }
        return alert
    }
    
    class func alertWithAction(title: String?, message: String?, alertActiontitle: String, handler: @escaping EmptyHandler) -> UIAlertController {
        let action = addAction(title: alertActiontitle, style: UIAlertAction.Style.default) { (_) in
            handler()
        }
        
        let alert = UIAlertController.alert(title: title, message: message, style: UIAlertController.Style.alert, action: action, cancelAction: nil)
        
        return alert
        
    }
    
    
}
