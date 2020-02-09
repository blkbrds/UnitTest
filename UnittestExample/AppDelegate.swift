//
//  AppDelegate.swift
//  UnitTestExample
//
//  Created by Lam Le V. on 7/7/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import UIKit
import Firebase
//https://firebase.google.com/docs/crashlytics/get-started?platform=ios&utm_source=fabric&utm_medium=inline_banner&utm_campaign=fabric_sunset&utm_content=kits_crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}
