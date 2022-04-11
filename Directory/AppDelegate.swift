//
//  AppDelegate.swift
//  Directory
//
//  Created by Bradley Mackey on 07/04/2022.
//

import UIKit
import ThemeService

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let theme = PrimaryTheme()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private func configureAppearance() {
        let color = theme.primaryBrandColor.uiColor()
        UITabBar.appearance().barTintColor = color
        UITabBar.appearance().tintColor = color
        
        UINavigationBar.appearance().tintColor = color
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}

