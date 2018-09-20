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
            context("When Password is empty") {
                it("`validatePassword` should throw Error when password empty") {
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.empty))
                }
            }

            context(" When Password is invalid") {
                it("`validatePassword` should throw length error when password has length < 8") {
                    viewModel.password = "abc"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validatePassword` should throw length error when password has length > 20") {
                    viewModel.password = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validatePassword` should throw format error when password has invalid format") {
                    viewModel.password = "abcdldlslsls@!$"
                    expect { try viewModel.validatePassword() }.to(throwError(PasswordError.invalid(reason: .format)))
                }
            }

            context(" When Password is valid") {
                it("`validatePassword` should not throw error") {
                    viewModel.password = "12345678abc"
                    expect { try viewModel.validatePassword() }.notTo(throwError())
                }
            }
        }

        describe("Test `validateUsername` function") {
            context("When username is empty") {
                it("`validateUsername` should throw Error when username empty") {
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.empty))
                }
            }

            context("When username is invalid") {
                it("`validateUsername` should throw format error when username has invalid format") {
                    viewModel.username = "abc"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it("`validateUsername` should throw format error when username has suffix '@asiantech.vn'") {
                    viewModel.username = "abc@gmail.com"
                    expect { try viewModel.validateUsername() }.to(throwError(UsernameError.invalid(reason: .format)))
                }
            }

            context("When username is valid") {
                it("`validateUsername` should not throw error") {
                    viewModel.username = "abc@asiantech.vn"
                    expect { try viewModel.validateUsername() }.notTo(throwError())
                }
            }
        }

        describe("Test `validate` function") {
            context("When username and password are empty") {
                it("`validate` should throw Error when username empty") {
                    expect { try viewModel.validate() }.to(throwError(UsernameError.empty))
                }
            }

            context("When username is valid, password is invalid") {
                it("`validate` should throw Error when password length") {
                    viewModel.username = "abc@asiantech.vn"
                    viewModel.password = "123"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.invalid(reason: .length)))
                }

                it("`validate` should throw Error when password format") {
                    viewModel.username = "abc@asiantech.vn"
                    viewModel.password = "12345678!@#"
                    expect { try viewModel.validate() }.to(throwError(PasswordError.invalid(reason: .format)))
                }
            }

            context("When username is invalid, password is valid") {
                it("`validate` should throw Error when password format") {
                    viewModel.username = "abc"
                    viewModel.password = "12345678abc"
                    expect { try viewModel.validate() }.to(throwError(UsernameError.invalid(reason: .format)))
                }

                it("`validate` should throw Error when password suffix") {
                    viewModel.username = "abc@gmail.com"
                    viewModel.password = "12345678abc"
                    expect { try viewModel.validate() }.to(throwError(UsernameError.invalid(reason: .suffix)))
                }
            }

            context("When username and password are valid") {
                it("`validate` should not throw Error") {
                    viewModel.username = "abc@asiantech.vn"
                    viewModel.password = "12345678abc"
                    expect { try viewModel.validate() }.notTo(throwError())
                }
            }
        }

        afterEach {
            viewModel = nil
        }
    }
}
