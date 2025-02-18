//
//  MustOneInfo.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/2/14.
//

import NetworkExtension
import SystemConfiguration.CaptiveNetwork


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
        let one = MaskRocketInfo.requDict()
        let two = MustMaskEhonInfo.requDict()
        let three = MaskMilkInfo.requDict()
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
