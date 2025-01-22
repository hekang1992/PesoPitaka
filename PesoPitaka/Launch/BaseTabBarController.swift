//
//  BaseTabBarController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = HomeViewController()
        let firstNavController = BaseNavigationController(rootViewController: firstVC)
        firstNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "homenor")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homesel")?.withRenderingMode(.alwaysOriginal))
        
        let secondVC = OrdersViewController()
        let secondNavController = BaseNavigationController(rootViewController: secondVC)
        secondNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ordernor")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ordersel")?.withRenderingMode(.alwaysOriginal))
        
        let thirdVC = UserCenterViewController()
        let thirdNavController = BaseNavigationController(rootViewController: thirdVC)
        thirdNavController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "centernor")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "centersel")?.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [firstNavController, secondNavController, thirdNavController]
    }
    
}


