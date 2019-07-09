//
//  AppDelegate.swift
//  UnitTestExample
//
//  Created by Lam Le V. on 7/7/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        #if DEBUG
        fatalError()
        #else
        return true
        #endif
    }

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}
