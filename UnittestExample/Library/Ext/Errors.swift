//
//  Errors.swift
//  UnittestExample
//
//  Created by Tung Nguyen C.T on 9/13/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation

enum PasswordErrorReason: String {
    case length = "Password's length must be greater than 7 and less than 21"
    case format = "A password can only contain alphanumeric characters with underscores, hyphens, periods, at sign"
}

enum UsernameErrorReason: String {
    case format = "Username must be a valid email address"
    case suffix = "Username must has suffix @asiantech.vn"
}

// Define errors
enum UsernameError: Error {
    case empty
    case invalid(reason: UsernameErrorReason)

    var localizedDescription: String {
        switch self {
        case .empty:
            return "Username is required"
        case .invalid(let reason):
            return reason.rawValue
        }
    }
}

enum PasswordError: Error {
    case empty
    case invalid(reason: PasswordErrorReason)

    var localizedDescription: String {
        switch self {
        case .empty:
            return "Password is required"
        case .invalid(let reason):
            return reason.rawValue
        }
    }
}

typealias Errors = App.Errors

extension App {

    enum Errors: Error {

        case indexOutOfBound
        case initFailure
    }
}
extension App.Errors: CustomStringConvertible {

    var description: String {
        switch self {
        case .indexOutOfBound: return "Index is out of bound"
        case .initFailure: return "Init failure"
        }
    }
}
