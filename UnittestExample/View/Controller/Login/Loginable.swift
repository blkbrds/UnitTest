//
//  Loginable.swift
//  UnittestExample
//
//  Created by ToanTV on 10/22/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation

protocol Loginable {

    var validateError: ((Error?) -> Void)? { get set }

    var validateSuccess: (() -> Void)? { get set }

    func login()

    var username: String { get set }

    var password: String { get set }
}
