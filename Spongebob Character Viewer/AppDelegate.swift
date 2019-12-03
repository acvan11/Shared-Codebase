//
//  AppDelegate.swift
//  Spongebob Character Viewer
//
//  Created by K Y on 11/21/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import XfinityCodingChallenge

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ServerConstants.SERVER_URL = "https://api.duckduckgo.com/?q=spongebob+squarepants+characters&format=json"
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplitViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

