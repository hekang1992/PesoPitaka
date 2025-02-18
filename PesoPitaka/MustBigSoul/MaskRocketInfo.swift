//
//  MaskRocketInfo.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/2/18.
//

import UIKit

struct DeviceInfoModel {
    let systemVersion: String
    let platform: String
    let lastLoginTime: String
    let bundleID: String
    let batteryLevel: Int
    let isCharging: Int
    
    var deviceInfoDictionary: [String: Any] {
        return [
            "turn": systemVersion,
            "blind": platform,
            "allow": lastLoginTime,
            "bundleID": bundleID,
            "upbringing": [
                "most": batteryLevel,
                "necromancers": isCharging
            ]
        ]
    }
}

class MaskRocketInfo: NSObject {
    
    static func getDeviceInfo() -> DeviceInfoModel {
        let systemVersion = UIDevice.current.systemVersion
        let platform = "ios"
        let lastLoginTime = getLastTime()
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let batteryInfo = getBatteryInfo()
        
        return DeviceInfoModel(
            systemVersion: systemVersion,
            platform: platform,
            lastLoginTime: lastLoginTime,
            bundleID: bundleID,
            batteryLevel: batteryInfo.level,
            isCharging: batteryInfo.isCharging
        )
    }
    
    private static func getLastTime() -> String {
        let onetime = ProcessInfo.processInfo.systemUptime
        let loginDate = Date(timeIntervalSinceNow: -onetime)
        let time = String(format: "%ld", Int(loginDate.timeIntervalSince1970 * 1000))
        return time
    }
    
    private static func getBatteryInfo() -> (level: Int, isCharging: Int) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let isCharging = UIDevice.current.batteryState == .charging ? 1 : 0
        return (batteryLevel, isCharging)
    }
    
    static func requDict() -> [String: Any] {
        let deviceInfo = getDeviceInfo()
        return deviceInfo.deviceInfoDictionary
    }
    
}
