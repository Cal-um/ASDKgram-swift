//
//  AppDelegate.swift
//  ASDKgram-Swift
//
//  Created by Calum Harris on 06/01/2017.
//  Copyright © 2017 Calum Harris. All rights reserved.
//

import UIKit
import AsyncDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		// UIKit Home Feed viewController & navController

		let UIKitNavController = UINavigationController(rootViewController: PhotoFeedTableViewController())
		UIKitNavController.tabBarItem.title = "UIKit"

		// ASDK Home Feed viewController & navController

		let ASDKNavController = UINavigationController(rootViewController: PhotoFeedTableNodeController())
		ASDKNavController.tabBarItem.title = "ASDK"

		// UITabBarController

		let tabBarController = UITabBarController()
		tabBarController.viewControllers = [UIKitNavController, ASDKNavController]
		tabBarController.selectedIndex = 1
		tabBarController.tabBar.tintColor = UIColor.mainBarTintColor()

		// Nav Bar appearance

		UINavigationBar.appearance().barTintColor = UIColor.mainBarTintColor()

		// UIWindow

		window = UIWindow()
		window?.backgroundColor = .white
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()

		return true
	}

}
