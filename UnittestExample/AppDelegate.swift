//
//  AppDelegate.swift
//  UnittestExample
//
//  Created by Quang Phu C. M. on 9/6/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configWindow()
        return true
    }

    // Step 1: Get Category list to get channelID

    // Step 2: Get playlist with channelID

    // Step 3: Get video list with playlistID
}

extension AppDelegate {

    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        let isDidLogin = Session.shared.isLogin
        if isDidLogin {
            configTabbar()
        } else {
            let vc = LoginViewController()
            let navi = UINavigationController(rootViewController: vc)
            window?.rootViewController = navi
        }
    }

    private func configTabbar() {
        let categoryVC = CategoriesViewController()
        let searchVC = SearchViewController()
        categoryVC.tabBarItem = UITabBarItem(title: "Category", image: #imageLiteral(resourceName: "home"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), tag: 1)
        let categoryNavi = UINavigationController(rootViewController: categoryVC)
        let searchNavi = UINavigationController(rootViewController: searchVC)
        let controllers = [categoryNavi, searchNavi]
        let tabbar = UITabBarController()
        tabbar.viewControllers = controllers
        window?.rootViewController = tabbar
    }
}
