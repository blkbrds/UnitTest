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

/**
 `validate()` function call and throws Error of 2 functions (validatePassword() and validateUsername() -> `Them`).
 So, just testing it with full case throws Error of `Them`.
 
 When test, performing the following tasks:
 - Test full case of `username`, then take a correct `username`
 - With correct `username` already, test full case of password
 */
final class LoginViewModelTests: QuickSpec {

    override func spec() {

        var viewModel: LoginViewModel!

        beforeEach {
            viewModel = LoginViewModel()
        }

        describe("Test validate") {
            context("When username is empty") {
                it("validate should throw empty username Error") {
                    expect { try viewModel.validate() }.to(throwError(UsernameError.empty))
                }
            }

            context("When username is invalid") {
                it("validate should throw format username Error)") {
                    viewModel.username = "cuong.doan"
                    expect { try viewModel.validate() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it("validate should throw suffix username Error)") {
                    viewModel.username = "cuong.doan@gmail.com"
                    expect { try viewModel.validate() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            context("When password is empty") {
                it("validate should throw empty password Error") {
                    viewModel.username = "cuong.doan@asiantech.vn"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.empty))
                }
            }

            context("When password is invalid") {
                it("validate should throw length password Error (password length < 8)") {
                    viewModel.username = "cuong.doan@asiantech.vn"
                    viewModel.password = "dmc"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("validate should throw length password Error (password length > 20)") {
                    viewModel.username = "cuong.doan@asiantech.vn"
                    viewModel.password = "doanminhcuong27111995"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("validate should throw format password Error)") {
                    viewModel.username = "cuong.doan@asiantech.vn"
                    viewModel.password = "dmc@2711"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.invalid(reason: .format)))
                }
            }

            context("When username and password are valid") {
                it("validate shouldn't throw error") {
                    viewModel.username = "cuong.doan@asiantech.vn"
                    viewModel.password = "dmc271195"
                    expect { try viewModel.validate() }.toNot(throwError())
                }
            }
        }

        afterEach {
            viewModel = nil
        }
    }
}
