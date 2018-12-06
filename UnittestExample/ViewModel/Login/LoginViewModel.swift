//
//  LoginViewModel.swift
//  UnittestExample
//
//  Created by Tung Nguyen C.T on 9/13/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import MVVM

final class LoginViewModel: ViewModel, Loginable {

    // MARK: - Properties
    var validateError: ((Error?) -> Void)?
    var validateSuccess: (() -> Void)?

    var username = "" {
        didSet {
            do {
                try validate()
                validateSuccess?()
            } catch {
                validateError?(error)
            }
        }
    }

    var password = "" {
        didSet {
            do {
                try validate()
                validateSuccess?()
            } catch {
                validateError?(error)
            }
        }
    }

    // MARK: - Private
    private func validatePassword() throws {

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

    private func validateUsername() throws {

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

    private func validate() throws {
        try validateUsername()
        try validatePassword()
    }

    func login() {
        let ud = UserDefaults.standard
        ud.set(username, forKey: "username")
        ud.set(password, forKey: "password")
    }
}
