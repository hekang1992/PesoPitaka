//
//  TotalModel.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/11.
//

struct BaseModel: Codable {
    var herself: String
    var washed: String
    var henceforth: henceforthModel
}

struct henceforthModel: Codable {
    var phone: String?
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case phone = "differently"
        case token = "gently"
    }
    
}
