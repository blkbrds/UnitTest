//
//  LoginViewController.swift
//  UnittestExample
//
//  Created by Tung Nguyen C.T on 9/13/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var usernameAlertLabel: UILabel!
    @IBOutlet weak var passwordAlertLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var viewModel = LoginViewModel()
    var isValidUser = false
    var isValidPass = false

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        validateData()
        checkLogin()
        passwordAlertLabel.text = ""
        usernameAlertLabel.text = ""
    }

    // MARK: - Private
    private func validateData() {
        viewModel.validateUserWhenValueChanged = { [weak self] in
            guard let this = self else { return }
            this.isValidUser = false
            this.checkLogin()
            do {
                try this.viewModel.validateUsername()
                this.usernameAlertLabel.text = ""
                this.isValidUser = true
                this.checkLogin()
            } catch let error as UsernameError {
                this.handle(error: error)
            } catch {
                this.usernameAlertLabel.text = "Unknown Error"
            }
        }

        viewModel.validatePasswordWhenValueChanged = { [weak self] in
            guard let this = self else { return }
            this.isValidPass = false
            this.checkLogin()
            do {
                try this.viewModel.validatePassword()
                this.passwordAlertLabel.text = ""
                this.isValidPass = true
                this.checkLogin()
            } catch let error as PasswordError {
                this.handle(error: error)
            } catch {
                this.passwordAlertLabel.text = "Unknown Error"
            }
        }
    }

    private func handle(error: PasswordError) {
        passwordAlertLabel.text = error.localizedDescription
    }

    private func handle(error: UsernameError) {
        usernameAlertLabel.text = error.localizedDescription
    }

    private func checkLogin() {
        if isValidUser && isValidPass {
            loginButton.backgroundColor = UIColor.RGB(225, 0, 0)
            loginButton.isUserInteractionEnabled = true
        } else {
            loginButton.isUserInteractionEnabled = false
            loginButton.backgroundColor = UIColor.RGB(146, 146, 146)
        }
    }
    // MARK: - Actions
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        switch sender {
        case usernameTextField:
            viewModel.username = text
        case passwordTextField:
            viewModel.password = text
        default: break
        }
    }

    @IBAction func loginButtonTouchInside(_ sender: UIButton) {
        // TODO: - Change Root here
        print("change root")
    }
}

extension LoginViewController: UITextFieldDelegate {

}
