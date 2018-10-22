//
//  LoginViewController.swift
//  TutorialApp
//
//  Created by Hai Nguyen H.P. on 11/28/17.
//  Copyright © 2017 Hai Nguyen H.P. All rights reserved.
//

import UIKit

final class LoginViewController: ViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var alertLabel: UILabel!

    var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isUserInteractionEnabled = false
        loginButton.backgroundColor = UIColor(red: 146.0,
                                                   green: 146.0,
                                                   blue: 146.0,
                                                   alpha: 1.0)
        configViewModel()
        alertLabel.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func configViewModel() {

        viewModel.validateError = { [weak self] error in
            guard let this = self else { return }
            this.loginButton.isUserInteractionEnabled = false
            this.loginButton.backgroundColor = UIColor(red: 146.0,
                                                       green: 146.0,
                                                       blue: 146.0,
                                                       alpha: 1.0)
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
            this.loginButton.backgroundColor = UIColor(red: 255.0,
                                                       green: 0.0,
                                                       blue: 0.0,
                                                       alpha: 1.0)
            this.configUI()
            this.loginButton.isUserInteractionEnabled = true
            this.alertLabel.text = ""
        }
    }

    private func configUI() {
        loginButton.cornerRadius = Config.cornerButton
    }

    private func handle(error: PasswordError) {
        alertLabel.text = error.localizedDescription
    }

    private func handle(error: UsernameError) {
        alertLabel.text = error.localizedDescription
    }

    private func dummyData() {
        emailTextField.text = "unit_test_pro@gmail.com"
        passwordTextField.text = "123123"
    }

    // MARK: - IBAction
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
        Session.shared.isLogin = true
        let vc = HomeViewController()
        navigationController?.pushViewController(vc)
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        switch sender {
        case emailTextField:
            viewModel.username = text
        case passwordTextField:
            viewModel.password = text
        default: break
        }
    }

    @IBAction func createNewAcountTouchUpInside(_ sender: UIButton) {
    }
}

extension LoginViewController {

    struct Config {
        static let cornerButton: CGFloat = 5
        static let colorBorderTextField: UIColor = .lightGray
        static let sizeBorderTextField: CGFloat = 1
        static let paddingTextField: CGFloat = 10
    }
}
