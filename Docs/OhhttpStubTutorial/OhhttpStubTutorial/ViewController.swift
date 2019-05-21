//
//  ViewController.swift
//  OhhttpStubTutorial
//
//  Created by Lam Le V. on 5/21/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import UIKit
import OHHTTPStubs

final class ViewController: UIViewController {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        requestApi()
    }

    private func requestApi() {
        let manager = Manager<User>()
        stub(condition: isHost("www.ios.com")) { _ in
            let stubPath = OHPathForFile("User.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        manager.request(path: "www.ios.com", method: .post) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let user):
                this.usernameLabel.text = user.name
                this.ageLabel.text = user.age?.description
            case .failure(let error):
                this.errorLabel.text = error.localizedDescription
            }
        }
    }
}
