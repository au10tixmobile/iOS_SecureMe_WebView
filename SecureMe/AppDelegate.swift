//
//  AppDelegate.swift
//  SecureMe
//
//  Created by Elkana Orbach on 03/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var incomingURL: URL!

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		
		
		return true
	}
	
	func application(_ application: UIApplication,
					 continue userActivity: NSUserActivity,
					 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
	{
		// Get URL components from the incoming user activity.
		guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
			let incomingURL = userActivity.webpageURL else {
			return false
		}
		self.incomingURL = incomingURL
		presentWKWebViewViewController()
		return true
	}

	func presentWKWebViewViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc: ViewController = storyboard.instantiateViewController(identifier: "ViewController")
		vc.url = self.incomingURL
		self.window?.rootViewController = vc
		self.window?.makeKeyAndVisible()
	}
}

