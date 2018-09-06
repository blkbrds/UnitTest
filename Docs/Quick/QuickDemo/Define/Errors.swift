//
//  Errors.swift
//  QuickDemo
//
//  Created by ToanTV on 3/20/18.
//  Copyright © 2018 ToanTV. All rights reserved.
//

import Foundation

enum Errors: Error {
    case indexOutOfBound
}

extension Errors: CustomStringConvertible {

    var description: String {
        switch self {
        case .indexOutOfBound: return "Index is out of bound"
        }
    }
}
