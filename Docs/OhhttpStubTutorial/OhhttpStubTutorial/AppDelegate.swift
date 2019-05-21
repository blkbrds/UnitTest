//
//  AppDelegate.swift
//  OhhttpStubTutorial
//
//  Created by Lam Le V. on 5/21/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

