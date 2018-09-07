//
//  AppDelegate.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }
}

extension AppDelegate {

    fileprivate func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        let movieVC = MoviesViewController()
        let navi = UINavigationController(rootViewController: movieVC)
        window.rootViewController = navi
        window.makeKeyAndVisible()
    }
}

