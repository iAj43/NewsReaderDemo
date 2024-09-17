//
//  AppDelegate.swift
//  NewsReaderDemo
//
//  Created by IA on 14/09/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - window
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let customTabBarController = CustomTabBarController()
        window?.rootViewController = customTabBarController
        window?.makeKeyAndVisible()
        return true
    }
}

