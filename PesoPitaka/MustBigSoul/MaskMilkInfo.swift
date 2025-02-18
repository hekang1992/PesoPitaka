//
//  MaskMilkInfo.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/2/18.
//

import UIKit
import DeviceKit

struct MaskMilkInfo {
    static func requDict() -> [String: Any] {
        let dict: [String: Any] = [
            "alone": aloneInfo
        ]
        return dict
    }
}

extension MaskMilkInfo {
    private static var aloneInfo: [String: Any] {
        return [
            "following": "",
            "followers": UIDevice.current.name,
            "empty": "",
            "space": String(format: "%.0f", UIScreen.main.bounds.height),
            "larger": String(format: "%.0f", UIScreen.main.bounds.width),
            "size": UIDevice.current.name,
            "similar": UIDevice.current.model,
            "material": String(Device.current.diagonal),
            "noticed": UIDevice.current.systemVersion
        ]
    }
}
