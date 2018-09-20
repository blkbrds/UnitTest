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

class LoginViewModelTests: QuickSpec {

    override func spec() {

        var viewModel: LoginViewModel!

        // MARK: - Before Each
        beforeEach {
            viewModel = LoginViewModel()
        }

        /// Test function `validatePassword()`
        describe("Test `validatePassword`") {
            context("when password is empty") {

                /// case with password empty
                it("`validatePassword` show error password empty") {
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.empty))
                }
            }

            context("when password is invalid") {

                /// case with password count > 20
                it("`validatePassword` show error password count > 20 ") {
                    viewModel.password = "abcde12345abcde123456"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                /// case with password count < 8
                it("`validatePassword` show error password count < 8 ") {
                    viewModel.password = "123456"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                /// case with password format
                it("`validatePassword` show error password format ") {
                    viewModel.password = "abc._@&%"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .format)))
                }

                /// case with password true
                it("show error password format ") {
                    viewModel.password = "iOS123456"
                    expect { try viewModel.validatePassword() }.toNot(throwError())
                }
            }
        }

        /// Test function `validateUsername()`
        describe("Test `validateUsername`") {
            context("when username empty") {
                it("`validateUsername` show error username empty") {
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.empty))
                }
            }

            context("when username invalid") {
                it("`validateUsername` show error username format") {
                    viewModel.username = "𝒊OS"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }
            }

            context("when username invalid") {
                it("`validateUsername` show error username suffix") {
                    viewModel.username = "thinh@gmail.com"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            context("when username invalid") {
                it("`validateUsername` not show error username ") {
                    viewModel.username = "thinh.nguyen@asiantech.vn"
                    expect { try viewModel.validateUsername() }.toNot(throwError())
                }
            }
        }

        /// Test funtion `validate()`
        describe("Test `validate`") {

            /// case with username and password true
            context("when username and password invalid") {
                it("`validate` username and password success") {
                    viewModel.username = "thinh.nguyen@asiantech.vn"
                    viewModel.password = "abcd9999999"
                    expect { try viewModel.validate() }.toNot(throwError())
                }
            }

            /// case with username false and password true
            context("when username and password invalid") {
                it("`validate` username failure and password success") {
                    viewModel.username = "thinh.nguyen@gmail.vn"
                    viewModel.password = "abcd9999999"
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            /// case with username false and password true
            context("when username and password invalid") {
                it("`validate` username success and password failure") {
                    viewModel.username = "thinh.nguyen@gmail.vn"
                    viewModel.password = "abcd9999999"
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            /// case with username and password false
            context("when username and password invalid") {
                it("`validate` username and password failure") {
                    viewModel.username = "thinh.nguyen@gmail.vn"
                    viewModel.password = "iOS"
                    expect { try viewModel.validate() }.to(throwError())
                }
            }
        }

        // MARK: - After Each
        afterEach {
            viewModel = nil
        }
    }
}
