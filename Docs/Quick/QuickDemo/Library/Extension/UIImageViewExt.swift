//
//  UIImageViewExt.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {

    func setImage(urlString: String?, placeholder: UIImage?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                image = placeholder
                return
        }
        kf.setImage(with: url, placeholder: placeholder)
    }
}
