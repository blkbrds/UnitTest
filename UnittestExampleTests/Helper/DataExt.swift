//
//  DataExt.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/16/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import UnittestExample

extension Data {

    init(forResource name: String?, ofType ext: String?, on `class`: AnyObject) {
        let bundle = Bundle(for: type(of: `class`))
        guard let path = bundle.path(forResource: name, ofType: ext), let data = Data(contentOf: URL(fileURLWithPath: path)) else {
            fatalError("\(name) is not valid or unselecting target member ship")
        }
        self = data
    }
}
