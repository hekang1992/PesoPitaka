//
//  LaunchViewController.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/11.
//

import UIKit

class LaunchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        monitorstatusInfo()
        loginSuccessPush.toRootVc()
    }

}

extension LaunchViewController {
    
    func monitorstatusInfo() {
        NetworkManager.shared.startListening()
    }
    
    
}
