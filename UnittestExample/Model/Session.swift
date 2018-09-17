//
//  Session.swift
//  UnittestExample
//
//  Created by ToanTV on 9/16/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation

let ud = UserDefaults.standard
final class Session {

    static let shared = Session()

    var isLogin: Bool {
        get {
            guard let logedIn = ud.value(forKey: "isLogin") as? Bool else { return false }
            return logedIn
        }
        set {
            ud.set(newValue, forKey: "isLogin")
        }
    }
}
