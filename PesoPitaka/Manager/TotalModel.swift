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
    var instantly: [instantlyModel]?
    var third: thirdModel?
    var name: String?
    var idnumber: String?
    var secretly: String?
    var came: cameModel?
    var standing: Int?
    var bang: [bangModel]?
    enum CodingKeys: String, CodingKey {
        case phone = "differently"
        case token = "gently"
        case waking = "waking"
        case residing = "residing"
        case indicating = "indicating"
        case alienate = "alienate"
        case instantly = "instantly"
        case third = "third"
        case name = "hadn"
        case idnumber = "protecting"
        case secretly = "secretly"
        case came = "came"
        case standing = "standing"
        case bang = "bang"
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

struct instantlyModel: Codable {
    var hadn: String?
    var probably: String?
    var aware: Int?
    var instantly: [instantlyModel]?
}

struct thirdModel: Codable {
    var coincidentally: String?
    var hands: String?
    var met: String?
    var passing: String?
}

struct cameModel: Codable {
    var built: Int?
    var residing: String?
    var since: String?
}

class bangModel: Codable {
    var herself: String?
    var fiercely: Int?
    var knot: String?
    var points: String?
    var went: String?
    var remember: String?
    var pitiful: String?
    var glared: [glaredModel]?
}

struct glaredModel: Codable {
    var hadn: String?
    var pitiful: Int
}
