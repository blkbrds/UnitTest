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
        describe("Test login ViewModel") {

            var viewModel: LoginViewModel!

            beforeEach {
                viewModel = LoginViewModel()
            }

            context("Test validate username") {

                it ("Username should be not empty") {
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.empty))
                }

                it ("Username should not have regex character") {
                    viewModel.username = "#s#slshe@sad%"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it ("Username must has suffix @asiantech.vn") {
                    viewModel.username = "khoanguyen@gmail.com"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            context("Test validate password") {
                it ("Password should be not empty") {
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.empty))
                }

                it ("Password's length must be greater than 8 and less than 20") {
                    viewModel.password = "abc"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it ("Password should have number of character between 8 and 20") {
                    viewModel.password = "motcuoctinhvuaquakemtheoloihuaphoipha"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it ("Password should not have regex character") {
                    viewModel.password = "@#s#slshe"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .format)))
                }
            }

            context("Validate function should be error") {
                it("Password and Username empty") {
                    expect { try viewModel.validate() }.to(throwError())
                }
            }

            context("Validate function should be success") {
                it("Password and Username correct") {
                    viewModel.username = "khoanguyen@asiantech.vn"
                    viewModel.password = "khoanguyen1192"
                    expect { try viewModel.validate() }.toNot(throwError())
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
