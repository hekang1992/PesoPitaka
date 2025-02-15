//
//  MustOneInfo.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/2/14.
//

import UIKit
import DeviceKit
import Alamofire
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

class MustOneInfo: NSObject {
    
    static func getLastTime() -> String{
        let onetime = ProcessInfo.processInfo.systemUptime
        let loginDate = Date(timeIntervalSinceNow: -onetime)
        let time = String(format: "%ld", Int(loginDate.timeIntervalSince1970 * 1000))
        return time
    }
    
    static func batteryInfo() -> [String: Any] {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let isCharging = UIDevice.current.batteryState == .charging ? 1 : 0
        return [
            "upbringing": [
                "most": batteryLevel,
                "necromancers": isCharging
            ]
        ]
    }
    
    static func requDict() -> [String: Any] {
        let turn = UIDevice.current.systemVersion
        let blind = "ios"
        let allow = MustOneInfo.getLastTime()
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        var dict = ["turn": turn,
                    "blind": blind,
                    "allow": allow,
                    "bundleID": bundleID] as [String: Any]
        dict.merge(MustOneInfo.batteryInfo()) { (current, _) in current }
        return dict
    }
    
}


class MustSendInfo: NSObject {
    
    static func getMacInfo() -> String {
        guard let inters = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in inters {
            guard let networkInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                  let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String else {
                continue
            }
            return bssid
        }
        return ""
    }
    
    static func getCurrentTime() -> String {
        let currentTime = Date().timeIntervalSince1970
        let currentTimeMillis = String(Int64(currentTime * 1000))
        return currentTimeMillis
    }
    
    static func isProxy() -> String {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any] else {
            return "0"
        }
        let testURL = URL(string: "https://www.apple.com")!
        guard let proxies = CFNetworkCopyProxiesForURL(testURL as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [[AnyHashable: Any]] else {
            return "0"
        }
        guard let proxyType = proxies.first?[kCFProxyTypeKey] as? String else {
            return "0"
        }
        return proxyType == kCFProxyTypeNone as String ? "0" : "1"
    }
    
    static func isVPN() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    static func isBreak() -> String {
        let phoneStr = "/Library/MobileSubstrate" + "/MobileSubstrate.dylib"
        let oneStr = "/Applications" + "/Cydia.app"
        let twoStr = "/usr" + "/sbin" + "/sshd"
        let jailbreakToolPaths = [
            oneStr,
            "/bin/bash",
            twoStr,
            "/usr/sbin/sshd",
            phoneStr,
        ]
        for path in jailbreakToolPaths {
            if FileManager.default.fileExists(atPath: path) {
                return "1"
            }
        }
        return "0"
    }
    
    static func getWifiName() -> String {
        var wifiInfo: String = "NONE"
        let reachabilityManager = NetworkReachabilityManager()
        let status = reachabilityManager?.status
        if status == .notReachable {
            wifiInfo = "NONE"
        } else if status == .reachable(.cellular) {
            wifiInfo = "5G/4G"
        } else if status == .reachable(.ethernetOrWiFi) {
            wifiInfo = "WIFI"
        }else {
            wifiInfo = "NONE"
        }
        return wifiInfo
    }
    
    static func timeStart() -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
    static func isSimulator() -> Int {
#if targetEnvironment(simulator)
        return 1
#else
        return 0
#endif
    }
    
    static func getDeviceLanguage() -> String {
        let preferredLanguages = Locale.preferredLanguages
        if let preferredLanguage = preferredLanguages.first {
            return preferredLanguage
        }
        return "Unknown"
    }
    
    static func requDict() -> [String: Any] {
        let than = AwkwardManager.getIDFV()
        let better = AwkwardManager.getIDFA()
        let listen = MustSendInfo.getMacInfo()
        let opposite = DateUtils.getCurrentTimestampInMilliseconds()
        let naturally: String = MustSendInfo.isProxy()
        let stiff = isVPN()
        let tone = isBreak()
        let need = isSimulator()
        let lead = getDeviceLanguage()
        let choice = ""
        let talk = getWifiName()
        let urged = NSTimeZone.system.abbreviation() ?? ""
        let impatiently = timeStart()
        
        let dict = ["hate": ["than": than,
                             "better": better,
                             "listen": listen,
                             "opposite": opposite,
                             "naturally": naturally,
                             "stiff": stiff,
                             "tone": tone,
                             "need": need,
                             "lead": lead,
                             "choice": choice,
                             "talk": talk,
                             "urged": urged,
                             "impatiently": impatiently]]
        return dict
    }
    
}

class MustBuyInfo: NSObject {
    
    static func requDict() -> [String: Any] {
        
        let following = ""
        let followers = UIDevice.current.name
        let empty = ""
        let space = String(format: "%.0f", SCREEN_HEIGHT)
        let larger = String(format: "%.0f", SCREEN_WIDTH)
        let size = UIDevice.current.name
        let similar = UIDevice.current.model
        let material = String(Device.current.diagonal)
        let noticed = UIDevice.current.systemVersion
        
        
        var dict: [String: Any] = ["alone": ["following": following,
                                             "followers": followers,
                                             "empty": empty,
                                             "space": space,
                                             "larger": larger,
                                             "size": size,
                                             "similar": similar,
                                             "material": material,
                                             "noticed": noticed]]
        return dict
        
    }
    
    
}

class MustMaskInfo: NSObject {
    
    static func getMacInfo() -> String {
        guard let inters = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in inters {
            guard let networkInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                  let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String else {
                continue
            }
            return bssid
        }
        return ""
    }
    
    static func getWiFiIPAddress() -> String? {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        for interfaceName in interfaceNames {
            if let networkInfo = CNCopyCurrentNetworkInfo(interfaceName as CFString) as? [String: Any] {
                if let ipAddress = networkInfo["SSID"] as? String {
                    return ipAddress
                }
            }
        }
        return nil
    }

    static func requDict() -> [String: Any] {
        
        let hadn: String  = MustMaskInfo.getWiFiIPAddress() ?? ""
        let guests: String  = MustMaskInfo.getMacInfo()
        let listen: String  = MustMaskInfo.getMacInfo()
        let treat: String  = MustMaskInfo.getWiFiIPAddress() ?? ""
        
        
        let dict = ["hadn": hadn,
                    "guests": guests,
                    "listen": listen,
                    "treat": treat]
        
        let array: [[String: String]] = [dict]
        let adict: [String: Any] = ["angrily": ["suki": MustMaskInfo.getWiFiIPAddress() ?? "",
                                                "rhaegar": array,
                                                "explain": dict,
                                                "house": 1]]
        return adict
    }
}

class MustSurgInfo: NSObject {
    
    static func getStorageInfo() -> (freeSpace: String, totalSpace: String)? {
        let fileManager = FileManager.default
        do {
            let systemAttributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
            if let freeSpace = (systemAttributes[.systemFreeSize] as? NSNumber)?.int64Value,
               let totalSpace = (systemAttributes[.systemSize] as? NSNumber)?.int64Value {
                let freeSpaceKB = Double(freeSpace) / 1024.0
                let totalSpaceKB = Double(totalSpace) / 1024.0
                let freeSpaceString = String(format: "%.0f", freeSpaceKB)
                let totalSpaceString = String(format: "%.0f", totalSpaceKB)
                return (freeSpaceString, totalSpaceString)
            }
        } catch {
            print("Error retrieving storage info: \(error)")
        }
        return nil
    }
    
    static func getMemoryInfo() -> (freeMemory: String, totalMemory: String)? {
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        let totalMemoryKB = Double(totalMemory) / 1024.0
        let totalMemoryString = String(format: "%.0f", totalMemoryKB)
        var freeMemory: UInt64 = 0
        var size = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size / MemoryLayout<integer_t>.size)
        let host = mach_host_self()
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size / MemoryLayout<integer_t>.size)
        
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(host, HOST_VM_INFO64, $0, &count)
            }
        }
        
        if result == KERN_SUCCESS {
            freeMemory = UInt64(stats.free_count) * UInt64(vm_page_size)
            let freeMemoryKB = Double(freeMemory) / 1024.0
            let freeMemoryString = String(format: "%.0f", freeMemoryKB)
            return (freeMemoryString, totalMemoryString)
        } else {
            print("Failed to retrieve memory info.")
            return nil
        }
    }
    
    
    static func requDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let storageInfo = getStorageInfo() {
            dict["familiar"] = storageInfo.freeSpace
            dict["firstly"] = storageInfo.totalSpace
        } else {
            print("Failed to retrieve storage info.")
        }
        
        if let memoryInfo = getMemoryInfo() {
            dict["fence"] = memoryInfo.freeMemory
            dict["politely"] = memoryInfo.totalMemory
        } else {
            print("Failed to retrieve memory info.")
        }
        
        
        let adict = ["secondly": dict]
        
        return adict
    }
}


class MustLpNineSte {
    
    static func getAllDinfo() -> [String: Any] {
        var dict: [String: Any] = [:]
        let one = MustOneInfo.requDict()
        let two = MustSendInfo.requDict()
        let three = MustBuyInfo.requDict()
        let four = MustMaskInfo.requDict()
        let five = MustSurgInfo.requDict()
        dict.merge(one) { current, _ in current }
        dict.merge(two) { current, _ in current }
        dict.merge(three) { current, _ in current }
        dict.merge(four) { current, _ in current }
        dict.merge(five) { current, _ in current }
        return dict
    }
    
}
