//
//  TotalModel.swift
//  PesoPitaka
//
//  Created by 何康 on 2025/1/11.
//

let firstUrl = "app://"
let middleUrl = "ios.pitaka."
let lastURL = "peso"

struct BaseModel: Codable {
    var herself: String
    var washed: String
    var henceforth: henceforthModel
}

struct henceforthModel: Codable {
    var phone: String?
    var token: String?
    var waking: wakingModel?
    var residing: String?
    var indicating: indicatingModel?
    var alienate: [alienateModel]?
    enum CodingKeys: String, CodingKey {
        case phone = "differently"
        case token = "gently"
        case waking = "waking"
        case residing = "residing"
        case indicating = "indicating"
        case alienate = "alienate"
    }
    
}

struct wakingModel: Codable {
    var pitiful: String?
    var own: [ownModel]?
}

struct ownModel: Codable {
    var aware: Int?
}

struct indicatingModel: Codable {
    var help: String?
}

struct alienateModel: Codable {
    var built: Int? //0==no 1==yes
}
