//
//  AppDelegate.swift
//  TableAndCollectionView
//
//  Created by Denis on 22.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = TableViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

