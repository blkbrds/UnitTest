//
//  InputView.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UITextView {
    var string: String {
        guard let text = text else { return "" }
        return text
    }
}

extension UITextField {
    var string: String {
        guard let text = text else { return "" }
        return text
    }
}
