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
        configViewModel()
        alertLabel.text = ""
    }

    // MARK: - Private
    private func configViewModel() {

        viewModel.validateError = { [weak self] error in
            guard let this = self else { return }
            this.loginButton.isUserInteractionEnabled = false
            this.loginButton.backgroundColor = UIColor.RGB(146, 146, 146)
            if let error = error as? UsernameError {
                this.handle(error: error)
            } else if let error = error as? PasswordError {
                this.handle(error: error)
            } else {
                this.alertLabel.text = "Unknown Error"
            }
        }

        viewModel.validateSuccess = { [weak self] in
            guard let this = self else { return }
            this.loginButton.backgroundColor = UIColor.RGB(225, 0, 0)
            this.loginButton.isUserInteractionEnabled = true
            this.alertLabel.text = ""
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
        Session.shared.isLogin = true
        let vc = CategoriesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {

}
