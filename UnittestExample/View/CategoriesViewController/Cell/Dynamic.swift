//
//  Dynamic.swift
//  UnittestExample
//
//  Created by Hai Phung N.T. on 10/1/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation

class Dynamic<T> {

    typealias Listener = (T) -> Void

    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}
