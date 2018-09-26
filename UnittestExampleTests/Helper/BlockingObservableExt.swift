//
//  BlockingObservableExt.swift
//  UnittestExample
//
//  Created by Su Nguyen T. on 9/24/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import RxBlocking

extension BlockingObservable {

    func firstOrNil() -> E? {
        do {
            return try first()
        } catch {
            return nil
        }
    }
}
