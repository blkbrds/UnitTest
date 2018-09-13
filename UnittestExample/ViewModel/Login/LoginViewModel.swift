//
//  LoginViewModel.swift
//  UnittestExample
//
//  Created by Tung Nguyen C.T on 9/13/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import MVVM

final class LoginViewModel: ViewModel {

    // MARK: - Properties
    var validateUserWhenValueChanged: (() -> Void)?
    var validatePasswordWhenValueChanged: (() -> Void)?

    var username = "" {
        didSet {
            validateUserWhenValueChanged?()
        }
    }

    var password = "" {
        didSet {
            validatePasswordWhenValueChanged?()
        }
    }

    // MARK: - Private
    func validatePassword() throws {

        if password.trimmed().isEmpty {
            throw PasswordError.empty
        }

        if password.count < 8 || password.count > 20 {
            throw PasswordError.invalid(reason: .length)
        }

        if !password.validate(String.Regex.PasswordRegex) {
            throw PasswordError.invalid(reason: .format)
        }
    }

    func validateUsername() throws {

        if username.trimmed().isEmpty {
            throw UsernameError.empty
        }

        if !username.validate(String.Regex.EmailRegex) {
            throw UsernameError.invalid(reason: .format)
        }

        if !username.hasSuffix("@asiantech.vn") {
            throw UsernameError.invalid(reason: .suffix)
        }
    }

    // MARK: - Public
    func validate() throws {
        try validatePassword()
        try validateUsername()
    }
}
