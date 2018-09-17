//
//  DataExt.swift
//  UnittestExample
//
//  Created by ToanTV on 9/16/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import UnittestExample

extension Data {

    init?(contentOf url: URL?) {
        guard let url = url,
            let data = try? Data(contentsOf: url) else {
                return nil
        }
        self = data
    }
}
