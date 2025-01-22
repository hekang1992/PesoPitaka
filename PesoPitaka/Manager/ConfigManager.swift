//
//  ConfigManager.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/21.
//

import UIKit
import SAMKeychain
import AdSupport

let ROOT_VC = "ROOT_VC"
let API_H5_URL = "http://8.220.190.138:8793"
let API_URL = "http://8.220.190.138:8793/pitaka"

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class AwkwardManager {
    static func getIDFV() -> String {
        if let storedIDFV = SAMKeychain.password(forService: API_URL, account: API_H5_URL), !storedIDFV.isEmpty {
            return storedIDFV
        }
        guard let deviceIDFV = UIDevice.current.identifierForVendor?.uuidString else {
            return ""
        }
        let success = SAMKeychain.setPassword(deviceIDFV, forService: API_URL, account: API_H5_URL)
        return success ? deviceIDFV : ""
    }
    
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
}

class CommonModel: Codable {
    var sip: String?
    var hot: String?
    var ha: String?
    var awkward: String?
    var atmosphere: String?
    var silently: String?
    var gently: String?
    var blew: String?
}

extension CommonModel {
    static func getCommonPera() -> CommonModel {
        let model = CommonModel()
        model.sip = "ios"
        model.hot = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        model.ha = UIDevice.current.name
        model.awkward = AwkwardManager.getIDFV()
        model.atmosphere = UIDevice.current.systemVersion
        model.silently = "vpesoapi"
        model.gently = ""
        model.blew = AwkwardManager.getIDFV()
        return model
    }
    
    func toDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        if let sip = self.sip { dict["sip"] = sip }
        if let hot = self.hot { dict["hot"] = hot }
        if let ha = self.ha { dict["ha"] = ha }
        if let awkward = self.awkward { dict["awkward"] = awkward }
        if let atmosphere = self.atmosphere { dict["atmosphere"] = atmosphere }
        dict["silently"] = self.silently
        if let gently = self.gently { dict["gently"] = gently }
        if let blew = self.blew { dict["blew"] = blew }
        return dict
    }
}

extension UIFont {
    
    class func regularFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
}

class UIUtils {
    static func createLabel(
        font: UIFont,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        text: String? = nil,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.backgroundColor = .clear
        label.text = text
        label.numberOfLines = numberOfLines
        return label
    }
}

extension UIColor {
    convenience init?(colorHexStr: String) {
        let hexString = colorHexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard hexString.hasPrefix("#") else {
            return nil
        }
        let hexCode = hexString.dropFirst()
        guard hexCode.count == 6, let rgbValue = UInt64(hexCode, radix: 16) else {
            return nil
        }
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

class DeviceMetrics {
    
    static var statusBarHeight: CGFloat {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    static var bottomSafeAreaHeight: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            return window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    static var tabBarHeight: CGFloat {
        let defaultTabBarHeight: CGFloat = 49
        return defaultTabBarHeight + bottomSafeAreaHeight
    }
}
