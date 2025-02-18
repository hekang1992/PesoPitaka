//
//  LoginSuccessConfig.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/21.
//

import UIKit
import Foundation

class loginSuccessPush {
    
    static func toRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
}

class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}
    
    enum UserDefaultsKey: String {
        case loginPhone = "LOGIN_PHONE"
        case loginToken = "LOGIN_TOKEN"
        case tntOneInfo = "TNT_ONE_INFO"
        case oneTime = "ONETIME"
        case twoTime = "TWOTIME"
    }
    
    func saveLoginInfo(phone: String, token: String) {
        UserDefaultsManager.setValue(phone, forKey: .loginPhone)
        UserDefaultsManager.setValue(token, forKey: .loginToken)
    }
    
    func removeLoginInfo() {
        UserDefaultsManager.removeValue(forKey: .loginPhone)
        UserDefaultsManager.removeValue(forKey: .loginToken)
        UserDefaultsManager.removeValue(forKey: .tntOneInfo)
        UserDefaultsManager.removeValue(forKey: .oneTime)
        UserDefaultsManager.removeValue(forKey: .twoTime)
    }
}

class UserDefaultsManager {
    
    static func setValue(_ value: Any, forKey key: LoginManager.UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func removeValue(forKey key: LoginManager.UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getValue(forKey key: LoginManager.UserDefaultsKey) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
}
