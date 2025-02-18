//
//  MustMaskEhonInfo.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/2/18.
//

import Foundation
import SystemConfiguration.CaptiveNetwork
import Alamofire

struct SkipStruct {
    let oneStr: String
    let twoStr: String
    let threeStr: String
    let fourStr: String
    init(oneStr: String = "/Library/MobileSubstrate/MobileSubstrate.dylib",
         twoStr: String = "/usr/sbin/sshd",
         threeStr: String = "/Applications/Cydia.app",
         fourStr: String = "/bin/bash") {
        self.oneStr = oneStr
        self.twoStr = twoStr
        self.threeStr = threeStr
        self.fourStr = fourStr
    }
}

struct MustMaskEhonInfo {
    static func requDict() -> [String: Any] {
        let dict: [String: Any] = [
            "hate": [
                "than": AwkwardManager.getIDFV(),
                "better": AwkwardManager.getIDFA(),
                "listen": macAddress,
                "opposite": currentTimestamp,
                "naturally": isUsingProxy,
                "stiff": isVPNEnabled,
                "tone": isJailbroken,
                "need": isSimulator,
                "lead": deviceLanguage,
                "choice": "",
                "talk": wifiName,
                "urged": timeZoneAbbreviation,
                "impatiently": systemUptime
            ]
        ]
        return dict
    }
}

extension MustMaskEhonInfo {
    
    private static var macAddress: String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return ""
        }
        for interface in interfaces {
            guard let networkInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                  let bssid = networkInfo[kCNNetworkInfoKeyBSSID as String] as? String else {
                continue
            }
            return bssid
        }
        return ""
    }
    
    private static var currentTimestamp: String {
        let currentTime = Date().timeIntervalSince1970
        return String(Int64(currentTime * 1000))
    }
    
    private static var isUsingProxy: String {
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
    
    private static var isVPNEnabled: Bool {
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
    
    private static var isJailbroken: String {
        let jailbreakPaths = SkipStruct()
        let allPaths = [jailbreakPaths.oneStr,
                        jailbreakPaths.twoStr,
                        jailbreakPaths.threeStr,
                        jailbreakPaths.fourStr]
        for path in allPaths {
            if FileManager.default.fileExists(atPath: path) {
                return "1"
            }
        }
        return "0"
    }
    
    private static var wifiName: String {
        let reachabilityManager = NetworkReachabilityManager()
        let status = reachabilityManager?.status
        switch status {
        case .notReachable:
            return "NONE"
        case .reachable(.cellular):
            return "5G/4G"
        case .reachable(.ethernetOrWiFi):
            return "WIFI"
        default:
            return "NONE"
        }
    }
    
    private static var systemUptime: String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
    private static var isSimulator: Int {
#if targetEnvironment(simulator)
        return 1
#else
        return 0
#endif
    }
    
    private static var deviceLanguage: String {
        return Locale.preferredLanguages.first ?? ""
    }
    
    private static var timeZoneAbbreviation: String {
        return NSTimeZone.system.abbreviation() ?? ""
    }
    
}
