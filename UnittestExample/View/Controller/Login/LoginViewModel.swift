//
//  LoginViewModel.swift
//  Tutorial
//
//  Created by Hai Nguyen H.P. on 12/26/17.
//  Copyright © 2017 Hai Nguyen H.P. All rights reserved.
//

import MVVM
import Foundation

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

        if password.trimmed.isEmpty {
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

        if username.trimmed.isEmpty {
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
