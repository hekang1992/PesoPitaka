//
//  MustOneInfo.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/2/14.
//

import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import MachO
import Foundation

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
    
    static func getWiFiIPBAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    let name = String(cString: (interface?.ifa_name)!)
                    if name == "en0" || name == "en1" {
                        
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
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
        let adict: [String: Any] = ["angrily": ["suki": MustMaskInfo.getWiFiIPBAddress() ?? "",
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
    
    static func getMemoryUsage() -> (used: String, free: String, total: String)? {
        let totalMemoryBytes = ProcessInfo.processInfo.physicalMemory
        
        var taskInfo = task_vm_info_data_t()
        var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
        let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
            }
        }
        
        guard result == KERN_SUCCESS else {
            return nil
        }
        
        let usedMemoryBytes = taskInfo.internal + taskInfo.compressed
        
        let freeMemoryBytes = totalMemoryBytes - UInt64(usedMemoryBytes)
        
        func bytesToKB(_ bytes: UInt64) -> String {
            return "\(bytes)"
        }
        
        let totalMemoryKB = bytesToKB(totalMemoryBytes)
        let usedMemoryKB = bytesToKB(UInt64(usedMemoryBytes))
        let freeMemoryKB = bytesToKB(freeMemoryBytes)
        
        return (used: usedMemoryKB, free: freeMemoryKB, total: totalMemoryKB)
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
