//
//  BaseNavigationController.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
    }
    


}
