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

        context("When init login viewModel ") {

            beforeEach {
                viewModel = LoginViewModel()
            }

            describe("Validate password") {

                it("'password' is empty") {
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.empty))
                }

                it("Password value for 8 to 20") {
                    viewModel.password = "123"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("Password different format") {
                    viewModel.password = "acxg31..."
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .format)))
                }

                it("Password true fromat") {
                    viewModel.password = "abcd1234"
                    expect { try viewModel.validatePassword() }.toNot(beNil())
                }
            }

            describe("Validate username") {

                it("Username is empty") {
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.empty))
                }

                it("Username different format") {
                    viewModel.username = "acafr.../"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it("Username true format") {
                    viewModel.username = "nhan@asiantech.vn"
                    expect { try viewModel.validateUsername() }.toNot(beNil())
                }

                it("Check has suffix") {
                    viewModel.username = "nhan@asiantaaaech.vn"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            describe("") {
                it("Validate") {
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
