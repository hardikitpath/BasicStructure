//
//  UIView+Extension.swift
//  WebCluesPracticle
//
//  Created by macbook pro on 21/07/20.
//  Copyright © 2020 macbook pro. All rights reserved.
//

import UIKit

public extension UIView {
    
    func centerXYAnchor(to view: UIView, yOffset: CGFloat = 0, leftOrRightOffset: CGFloat? = nil) {
           self.translatesAutoresizingMaskIntoConstraints = false
           self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset).isActive = true
           if let offset = leftOrRightOffset {
               self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: offset).isActive = true
           }
       }
}
