//
//  CustomTabBarController.swift
//  NewsReaderDemo
//
//  Created by IA on 15/09/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    //
    // MARK: - viewWillAppear
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBarAppearance()
    }
    
    func setupTabBarAppearance() {
        if #available(iOS 13.0, *) {
            let tabAppearance = UITabBarAppearance()
            tabAppearance.configureWithOpaqueBackground()
            tabAppearance.backgroundImage = UIImage()
            tabAppearance.backgroundColor = .primaryDark
            tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
            tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
            tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
            UITabBar.appearance().standardAppearance = tabAppearance
            if #available(iOS 15, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabAppearance
            }
            setNeedsStatusBarAppearanceUpdate()
            tabBarController?.tabBar.tintColor = .white
            tabBarController?.tabBar.barTintColor = .primaryDark
            tabBarController?.tabBar.isTranslucent = false
        } else {
            // Handle older versions prior to iOS 13.0
            tabBarController?.tabBar.tintColor = .white
            tabBarController?.tabBar.barTintColor = .primaryDark
            tabBarController?.tabBar.isTranslucent = false
        }
    }
    
    //
    // MARK: - viewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the first view controller
        let firstViewController = HomeController()
        let firstTabBarItem = UITabBarItem(
            title: StringConstants.tabBarHome,
            image: UIImage(named: ImageConstants.iconHome)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: ImageConstants.iconHomeSelected)?.withRenderingMode(.alwaysOriginal)
        )
        firstViewController.tabBarItem = firstTabBarItem
        
        // Create the second view controller
        let secondViewController = BookmarksController()
        let secondTabBarItem = UITabBarItem(
            title: StringConstants.tabBarBookmarks,
            image: UIImage(named: ImageConstants.iconBookmarks)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: ImageConstants.iconBookmarksSelected)?.withRenderingMode(.alwaysOriginal)
        )
        secondViewController.tabBarItem = secondTabBarItem
        
        // Set the view controllers of the tab bar controller
        self.viewControllers = [firstViewController, secondViewController]
    }
}
