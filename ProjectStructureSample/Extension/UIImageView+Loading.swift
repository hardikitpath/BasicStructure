//
//  UIImageView+Loading.swift
//  HomeOpenReferralPhone
//
//  Created by Ekta on 17/08/18.
//  Copyright © 2018 Technobrave Pty Ltd. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {

    func setImage(with string: String?, placeholderImage: UIImage?, completion: (() -> ())? = nil) {
        guard let validString = string, let url = URL(string: validString) else {
            self.image = placeholderImage
            return
        }
        self.af.setImage(withURL: url, placeholderImage: placeholderImage, completion:  { result in
            completion?()
        })
    }

    func cancleRequest() {
        self.af.cancelImageRequest()
    }

    func applyShadow() {

    }

}
