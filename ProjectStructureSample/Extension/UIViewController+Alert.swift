//
//  UIViewController+Alert.swift
//  HomeOpenReferralPhone
//
//  Created by Ekta on 13/08/18.
//  Copyright © 2018 Technobrave Pty Ltd. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    internal func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String? = "") {
        let alert = UIAlertController.alert(title: title, message: message)
        presentAlert(alert)
    }
    
    func showAlert(title: String?, message: String?, action: UIAlertAction? = nil, cancelAction: UIAlertAction? = nil) {
        let alert = UIAlertController.alert(title: title, message: message, action: action, cancelAction: cancelAction)
        presentAlert(alert)
    }
    
    func showAlert(title: String?, message: String?, okAction handler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            handler?()
        }
        alert.addAction(okAction)
        presentAlert(alert)
    }
    
    func showAlert(title: String, message: String?, confirmationHandler: @escaping ((Bool)-> Void)) {
        let alert = UIAlertController.alert(title: title, message: message, confirmationHandler: confirmationHandler)
        presentAlert(alert)
    }
    
    func showAlert(error: NSError, action: UIAlertAction? = nil) {
        showAlert(title: error.localizedDescription, message: error.localizedFailureReason, cancelAction: action)
    }
    
    func showAlert(title: String = "", attributedMessage: NSAttributedString) {
        let alert = UIAlertController.alert(title: "\(title)\n")
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        presentAlert(alert)
    }
    
    func openActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        for action in actions {
            alert.addAction(action)
        }
        
//        alert.view.tintColor = UIColor.themeTint
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentAlert(alert)
        
    }
    
    func alertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction)-> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
    
    func showAlert(alert: UIAlertController) {
        presentAlert(alert)
    }
    
    func dismissAlert() {
        if self is UIAlertController {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String?, message: String?, actionTitles:[String?],cancelButtonTitle: String? = nil, actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let buttonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActionSheet(title: String?, options: [String], selectedIndex: Int?, handler: @escaping ((Int?) -> Void)) {
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel) { _ in
            print("User canceled action sheet.")
            handler(nil)
        }
        
        
        let sheet = UIAlertController.alert(title: title, style: .actionSheet, cancelAction: cancelAction)
        for option in options {
            let index: Int? = options.firstIndex(of: option)
            var title = option
            if (selectedIndex != nil && index == selectedIndex) {
                title = "    \(option) \u{2713}"
            }
            
            let action = UIAlertAction.init(title: title, style: .default, handler: { _ in
                if let index = index {
                    print("User selected action sheet option at index: \(index); '\(option))'.")
                    handler(index)
                }
                else {
                    print("Error!!! User selected action sheet option at Unknown index).")
                }
            })
            sheet.addAction(action)
        }
        
        if let popoverController = sheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(sheet, animated: true, completion: nil)
    }
    
    func showActionSheet(title: String?, options: [String], selectedItem: String, handler: @escaping ((String?) -> Void)) {
        let index = options.firstIndex(of: selectedItem)
        self.showActionSheet(title: title, options: options, selectedIndex: index) { (selectedIdx) in
            if let selectedIndex = selectedIdx, selectedIndex < options.count {
                let selectedItem = options[selectedIndex]
                handler(selectedItem)
            } else {
                handler(nil)
            }
        }
    }
    
    func showAlert(with error: AppError) {
        let alert = UIAlertController(title: error.title, message: nil, preferredStyle: .alert)

        let okAction = alertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        presentAlert(alert)
    }
    
    func showAlert(title: String?, message: String?, handler: @escaping EmptyHandler) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_) in
            handler()
        }
        alert.addAction(okAction)
        presentAlert(alert)
    }
    
//    func showAlert(with error: AppError, or view: UIView? = nil)  {
//        
//    }
    
    func showAlert(title: String?, message: String?, alertActionTitle: String = "Refresh", handler: @escaping EmptyHandler) {
        
        let alert = UIAlertController.alertWithAction(title: title, message: message, alertActiontitle: alertActionTitle) {
           handler()
        }
        presentAlert(alert)
    }
}

extension UIViewController {
    func dismissAllViewControllers(animated: Bool, completion: @escaping ()->Void) {
        
        guard let vc = self.presentingViewController else {
            completion()
            return
        }
        
        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: animated, completion: {
                completion()
            })
        }
    }
}

extension UIViewController {
    
    func topMostViewController() -> UIViewController {
        
        if let navController = self as? UINavigationController, let visibleViewController = navController.visibleViewController {
            return visibleViewController.topMostViewController()
        }
        
        if let tabbarController = self as? UITabBarController,
           let selectedViewController = tabbarController.selectedViewController {
            return selectedViewController.topMostViewController()
        }
        
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        
        return self
    }
}


