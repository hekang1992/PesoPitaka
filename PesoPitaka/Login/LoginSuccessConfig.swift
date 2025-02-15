//
//  LoginSuccessConfig.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit

let LOGIN_TOKEN = "LOGIN_TOKEN"
let LOGIN_PHONE = "LOGIN_PHONE"

class LoginSuccessConfig {

    static func saveLoginInfo(phone: String, token: String) {
        UserDefaults.standard.setValue(phone, forKey: LOGIN_PHONE)
        UserDefaults.standard.setValue(token, forKey: LOGIN_TOKEN)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo() {
        UserDefaults.standard.setValue("", forKey: LOGIN_PHONE)
        UserDefaults.standard.setValue("", forKey: LOGIN_TOKEN)
        UserDefaults.standard.setValue("", forKey: TNT_ONE_INFO)
        UserDefaults.standard.setValue("", forKey: ONETIME)
        UserDefaults.standard.setValue("", forKey: TWOTIME)
        UserDefaults.standard.synchronize()
    }
    
}

class loginSuccessPush {
    
    static func toRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
}
