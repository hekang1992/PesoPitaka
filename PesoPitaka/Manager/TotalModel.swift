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
    var piece: pieceModel?
    var summoned: summonedModel?
    var original: originalModel?
    var forced: forcedModel?
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
        case piece = "piece"
        case summoned = "summoned"
        case original = "original"
        case forced = "forced"
    }
    
}

struct wakingModel: Codable {
    var pitiful: String?
    var own: [ownModel]?
}

struct ownModel: Codable {
    var aware: Int?
    var amountMax: String?
    var blinked: String?
    var bright: String?
    var getting: String?
    var host: String?
    var residing: String?
    var yawned: String?
    var sound: String?
    var loanTermText: String?
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
    var blinked: String?
    var getting: String?
    var orderAmount: String?
    var moneyText: String?
    var dateValue: String?
    var dateText: String?
    var secret: secretModel?
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
    var hadn: String?
    var helped: String?
    var liz: String?
    var settle: String?
    var northwest: [glaredModel]?
    var glared: [glaredModel]?
    var bang: [bangModel]?
    enum CodingKeys: String, CodingKey {
        case herself = "herself"
        case fiercely = "fiercely"
        case knot = "knot"
        case points = "points"
        case went = "went"
        case remember = "remember"
        case pitiful = "pitiful"
        case hadn = "hadn"
        case helped = "helped"
        case liz = "liz"
        case settle = "settle"
        case northwest = "northwest"
        case glared = "glared"
        case bang = "bang"
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.herself = try container.decodeIfPresent(String.self, forKey: .herself)
        self.fiercely = try container.decodeIfPresent(Int.self, forKey: .fiercely)
        self.knot = try container.decodeIfPresent(String.self, forKey: .knot)
        self.points = try container.decodeIfPresent(String.self, forKey: .points)
        self.went = try container.decodeIfPresent(String.self, forKey: .went)
        self.remember = try container.decodeIfPresent(String.self, forKey: .remember)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .pitiful) {
            self.pitiful = String(intValue)
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .pitiful) {
            self.pitiful = stringValue
        } else {
            self.pitiful = ""
        }
        self.hadn = try container.decodeIfPresent(String.self, forKey: .hadn)
        self.helped = try container.decodeIfPresent(String.self, forKey: .helped)
        self.liz = try container.decodeIfPresent(String.self, forKey: .liz)
        self.settle = try container.decodeIfPresent(String.self, forKey: .settle)
        self.northwest = try container.decodeIfPresent([glaredModel].self, forKey: .northwest)
        self.glared = try container.decodeIfPresent([glaredModel].self, forKey: .glared)
        self.bang = try container.decodeIfPresent([bangModel].self, forKey: .bang)
    }
}

class glaredModel: Codable {
    var hadn: String?
    var pitiful: String
    var mention: String?
    enum CodingKeys: String, CodingKey {
        case hadn = "hadn"
        case pitiful = "pitiful"
        case mention = "mention"
    }
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hadn = try container.decodeIfPresent(String.self, forKey: .hadn)
        self.mention = try container.decodeIfPresent(String.self, forKey: .mention)
        if let intValue = try? container.decodeIfPresent(Int.self, forKey: .pitiful) {
            self.pitiful = String(intValue)
        } else if let stringValue = try? container.decodeIfPresent(String.self, forKey: .pitiful) {
            self.pitiful = stringValue
        } else {
            self.pitiful = ""
        }
    }
}

class pieceModel: Codable {
    var instantly: [bangModel]?
}

struct summonedModel: Codable {
    var orderID: String?
    enum CodingKeys: String, CodingKey {
        case orderID = "tauren"
    }
}

struct originalModel: Codable {
    var own: [ownModel]?
}

struct forcedModel: Codable {
    var own: [ownModel]?
}

struct secretModel: Codable {
    var although: String?
    var liar: String?
    var good: Int?
}
