//
//  LoginViewModelTests.swift
//  UnittestExampleTests
//
//  Created by Tung Nguyen C.T. on 9/14/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import UnittestExample

final class LoginViewModelTests: QuickSpec {

    override func spec() {

        var viewModel: LoginViewModel!

        describe("Test login view model") {

            beforeEach {
                viewModel = LoginViewModel()
            }

            // test username
            // empty username
            context("If username is empty") {

                it("`validateUsername` should throw error username is empty") {
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.empty))
                }

            }

            // invalid username
            context("If username is invalid") {

                it("`validateUsername` should throw error user name has invalid format") {
                    viewModel.username = "abc"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it("`validateUsername` should throw error user name has invalid suffix") {
                    viewModel.username = "abc@gmail.com"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            // valid user name
            context("If username is valid") {

                beforeEach {
                    viewModel.username = "van.le@asiantech.vn"
                }

                it("`validateUsername` should not throw error") {
                    expect { try viewModel.validateUsername() }.notTo(throwError())
                }

            }

            // test password
            // empty password
            context("If password is empty") {

                it("`validatePassword` should throw error password is empty") {
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.empty))
                }
            }

            // invalid password
            context("If password is invalid") {

                it("`validatePassword` should throw error password has invalid length when length < 8") {
                    viewModel.password = "abc"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validatePassword` should throw error password has invalid length when length > 20") {
                    viewModel.password = "111111111111111111111111111111111111111"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validatePassword` should throw error password has invalid format") {
                    viewModel.password = "aaaaa#aaaa"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .format)))
                }
            }

            // valid password
            context("If password is valid") {

                beforeEach {
                    viewModel.password = "aaaaaaaaaa"
                }

                it("`validatePassword` should not throw error") {
                    expect { try viewModel.validatePassword() }.notTo(throwError())
                }
            }

            // test function validate()
            context("If username and password are empty") {

                it("`validate` should throw error") {
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            context("If username is invalid") {

                beforeEach {
                    viewModel.username = "hhh"
                }

                it("`validate` should throw error") {
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            context("If username is valid and password is invalid") {

                beforeEach {
                    viewModel.username = "van.le@asiantech.vn"
                    viewModel.password = "aaa"
                }

                it("`validate` should throw error") {
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            context("If both username and password are valid") {

                beforeEach {
                    viewModel.username = "van.le@asiantech.vn"
                    viewModel.password = "aaaaaaaaaa"
                }

                it("`validate` should not throw error") {
                    expect { try viewModel.validate() }.notTo(throwError())
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
