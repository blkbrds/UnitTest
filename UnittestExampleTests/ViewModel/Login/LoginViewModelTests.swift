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

        beforeEach {
            viewModel = LoginViewModel()
        }

        describe("Test `validatePassword` function") {

            context("When password is empty") {

                it("`validatePassword` should throw error password empty") {
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.empty))
                }
            }

            context("When password is invalid") {

                it("`validatePassword` should throw length error when password count < 8") {
                    viewModel.password = "abc"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validatePassword` should throw length error when password count > 20") {
                    viewModel.password = "abc1234578910abcabcabcduu4h7flak"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validatePassword` should throw format error") {
                    viewModel.password = "abcc._@&"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .format)))
                }
            }

            context("When password is valid") {

                it("`validatePassword` shouldn't throw error") {
                    viewModel.password = "abcd12345"
                    expect { try viewModel.validatePassword() }.toNot(throwError())
                }
            }
        }

        describe("Test `validateUsername` function") {

            context("When username is empty") {

                it("`validateUsername` should throw error password empty") {
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.empty))
                }
            }

            context("When username is invalid") {

                it("`validateUsername` should throw format error") {
                    viewModel.username = "abc"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it("`validateUsername` should throw suffix error") {
                    viewModel.username = "abc@gmail.com"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            context("When username is valid") {

                it("`validateUsername` shouldn't throw error") {
                    viewModel.username = "tung.nguyen@asiantech.vn"
                    expect { try viewModel.validateUsername() }.toNot(throwError())
                }
            }
        }

        describe("Test `validate` function") {

            context("When username & password are empty") {

                it("`validate` should throw error username empty") {
                    expect { try viewModel.validate() }.to(throwError(UsernameError.empty))
                }
            }

            context("When username is valid, password is invalid") {

                it("`validate` shouldn't throw error") {
                    viewModel.username = "tung.nguyen@asiantech.vn"
                    viewModel.password = "1234"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.invalid(reason: .length)))
                }
            }

            context("When username & password are valid") {

                it("`validate` shouldn't throw error") {
                    viewModel.username = "tung.nguyen@asiantech.vn"
                    viewModel.password = "abcd12345"
                    expect { try viewModel.validate() }.toNot(throwError())
                }
            }
        }

        afterEach {
            viewModel = nil
        }
    }
}
