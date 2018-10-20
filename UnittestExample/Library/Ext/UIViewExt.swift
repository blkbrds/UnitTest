//
//  UIViewExt.swift
//  UnittestExample
//
//  Created by MBA0237P on 10/19/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

extension UIView {

    func shadow(color: UIColor, offset: CGSize = CGSize(width: 0, height: 0), opacity: Float = 1.0, radius: CGFloat = 3.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
