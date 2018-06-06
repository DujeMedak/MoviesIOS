//
//  AppDelegate.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = SearchMovieViewController()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.isTranslucent = false
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        return true
    }
    
}

