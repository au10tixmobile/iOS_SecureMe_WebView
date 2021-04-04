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
        
        guard let viewConroller = window?.rootViewController as? ViewController else{
            return false
        }
        viewConroller.load(url: incomingURL)

        return true
	}

}

