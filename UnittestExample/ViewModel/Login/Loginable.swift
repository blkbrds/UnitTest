//
//  Loginable.swift
//  UnittestExample
//
//  Created by Hai Phung N.T. on 10/1/18.
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
