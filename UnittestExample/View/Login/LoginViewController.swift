//
//  LoginViewController.swift
//  UnittestExample
//
//  Created by Tung Nguyen C.T on 9/13/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var viewModel = LoginViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        validateData()
        alertLabel.text = ""
    }

    // MARK: - Private
    private func validateData() {
        viewModel.validateWhenValueChanged = { [weak self] in
            guard let this = self else { return }
            this.loginButton.isUserInteractionEnabled = false
            this.loginButton.backgroundColor = UIColor.RGB(146, 146, 146)

            do {
                try this.viewModel.validate()
                this.alertLabel.text = ""
                this.loginButton.backgroundColor = UIColor.RGB(225, 0, 0)
                this.loginButton.isUserInteractionEnabled = true
            } catch let error as UsernameError {
                this.handle(error: error)
            } catch let error as PasswordError {
                this.handle(error: error)
            } catch {
                this.alertLabel.text = "Unknown Error"
            }
        }
    }

    private func handle(error: PasswordError) {
        alertLabel.text = error.localizedDescription
    }

    private func handle(error: UsernameError) {
        alertLabel.text = error.localizedDescription
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
