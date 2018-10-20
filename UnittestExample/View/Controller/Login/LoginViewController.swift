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

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        dummyData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func configUI() {
        loginButton.cornerRadius = Config.cornerButton
    }

    private func dummyData() {
        emailTextField.text = "unit_test_pro@gmail.com"
        passwordTextField.text = "123123"
    }

    // MARK: - IBAction
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
        let vc = HomeViewController()
        navigationController?.pushViewController(vc)
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
