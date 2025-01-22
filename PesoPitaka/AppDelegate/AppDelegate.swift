//
//  AppDelegate.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/11.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getConfig()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    
}


extension AppDelegate {
    
    private func getConfig() {
        //keybord
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //rootvc
        NotificationCenter.default.addObserver(self, selector: #selector(getRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    
    @objc private func getRootVc(_ noti: Notification) {
        let needLogin = UserDefaults.standard.object(forKey: LOGIN_TOKEN) as? String ?? ""
        window?.rootViewController = needLogin.isEmpty ? BaseNavigationController(rootViewController: LoginViewController()) : BaseNavigationController(rootViewController: BaseTabBarController())
    }
    
}
