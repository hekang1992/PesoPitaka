//
//  ServerDataManager.swift
//  PesoPitaka
//
//  Created by Benjamin on 2025/1/25.
//

import UIKit

final class ServerDataManager {
    
    static let shared = ServerDataManager()
    
    private init() {}
    
    private var serverData: [instantlyModel] = []
    
    func saveData(_ data: [instantlyModel]) {
        serverData = data
    }
    
    func getData() -> [instantlyModel] {
        return serverData
    }
    
    func clearData() {
        serverData = []
    }
}
