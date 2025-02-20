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
    
    static func getStorageUsage() -> (used: UInt64, free: UInt64, total: UInt64)? {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityKey, .volumeTotalCapacityKey])
            if let free = values.volumeAvailableCapacity, let total = values.volumeTotalCapacity {
                let used = total - free
                return (used: UInt64(used), free: UInt64(free), total: UInt64(total))
            }
        } catch {
            print("Error: Failed to get storage usage - \(error)")
        }
        return nil
    }
    
    static func getMemoryUsage() -> (used: UInt64, free: UInt64, total: UInt64)? {
        let HOST_VM_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        var size = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size)
        var hostInfo = vm_statistics_data_t()

        let result = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics(mach_host_self(), HOST_VM_INFO, $0, &size)
            }
        }

        if result == KERN_SUCCESS {
            let totalMemory = ProcessInfo.processInfo.physicalMemory
            let freeMemory = UInt64(hostInfo.free_count) * UInt64(vm_page_size)
            let usedMemory = totalMemory - freeMemory
            return (used: usedMemory, free: freeMemory, total: totalMemory)
        } else {
            print("Error: Failed to get memory usage")
            return nil
        }
    }
    
    
    static func requDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let storageInfo = getStorageUsage() {
            dict["familiar"] = storageInfo.free
            dict["firstly"] = storageInfo.total
        } else {
            print("Failed to retrieve storage info.")
        }
        
        if let memoryInfo = getMemoryUsage() {
            dict["politely"] = memoryInfo.free
            dict["fence"] = memoryInfo.total
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
