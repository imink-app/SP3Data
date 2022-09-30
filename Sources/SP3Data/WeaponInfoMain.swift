import Foundation

public extension WeaponInfoMain {
    
    static let allCases: [WeaponInfoMain] = {
        let jsonUrl = extractedDataDir
            .appendingPathComponent("mush", isDirectory: true)
            .appendingPathComponent("WeaponInfoMain.json", isDirectory: false)
        let jsonData = try! Data(contentsOf: jsonUrl)
        let result = try! JSONDecoder().decode([WeaponInfoMain].self, from: jsonData)
        return result
    }()
    
    var localizedName: String? {
        let key = "CommonMsg/Weapon/WeaponName_Main/" + __rowId
        let value = Bundle.module.localizedString(forKey: key, value: "[\(__rowId)]", table: "Extracted")
        return value == __rowId ? nil : value
    }
    
    var subWeaponRowID: String? {
        var sub = subWeapon
        guard !sub.isEmpty else {
            return nil
        }
        guard sub.hasPrefix("Work/Gyml/"), sub.hasSuffix(".spl__WeaponInfoSub.gyml") else {
            assertionFailure("unknown sub weapon format")
            return nil
        }
        sub.removeFirst(10)
        sub.removeLast(24)
        return sub
    }
    
    func imageURL(style: WeaponImageStyle = .normal) -> URL? {
        let url: URL
        switch style {
        case .normal:
            url = extractedImageDir
                .appendingPathComponent("weapon", isDirectory: true)
                .appendingPathComponent("Wst_\(__rowId).png", isDirectory: false)
        case .flat:
            url = extractedImageDir
                .appendingPathComponent("weapon_flat", isDirectory: true)
                .appendingPathComponent("Path_Wst_\(__rowId).png", isDirectory: false)
        case .badge00:
            url = extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WeaponLevel_\(__rowId)_Lv00.png", isDirectory: false)
        case .badge01:
            url = extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WeaponLevel_\(__rowId)_Lv01.png", isDirectory: false)
        case .sticker00:
            url = extractedImageDir
                .appendingPathComponent("zakka", isDirectory: true)
                .appendingPathComponent("Stc_Sti_Wst_\(__rowId)_Lv00.png", isDirectory: false)
        case .sticker01:
            url = extractedImageDir
                .appendingPathComponent("zakka", isDirectory: true)
                .appendingPathComponent("Hla_Sti_Wst_\(__rowId)_Lv01.png", isDirectory: false)
        default:
            return nil
        }
        return url.nilIfUnreachable()
    }
    
    static var supportedImageStyles: [WeaponImageStyle] {
        return [.normal, .flat, .badge00, .badge01, .sticker00, .sticker01]
    }
}

// MARK: - Generated Structure

public struct WeaponInfoMain: WeaponInfo, Codable, Hashable, CaseIterable {
    
    public let debugDispColumn: Int
    public let debugDispOrder: Int
    public let defaultDamageRateInfoRow: DamageRateInfoRow
    public let defaultHitEffectorType: HitEffectorType
    public let extraDamageRateInfoRowSet: [DamageRate]
    public let extraHitEffectorInfoSet: [HitEffector]
    public let gameActor: String
    public let id: Int
    public let isCoopRare: Bool
    public let lObjParam: String
    public let label: String
    public let lockerContentInfo: [String]
    public let matchingId: Int
    public let npcActor: String
    public let range: Double
    public let rewardLv2, rewardLv3, rewardLv4, rewardLv5: String
    public let season: Int
    public let shopPrice: Int
    public let shopUnlockRank: Int
    public let specActor: String
    public let specialPoint: Int
    public let specialWeapon: String
    public let subWeapon: String
    public let type: WeaponType
    public let uiParam: [UIParam]
    public let weaponInfoForCoop: String
    public let __rowId: String

    enum CodingKeys: String, CodingKey {
        case debugDispColumn = "DebugDispColumn"
        case debugDispOrder = "DebugDispOrder"
        case defaultDamageRateInfoRow = "DefaultDamageRateInfoRow"
        case defaultHitEffectorType = "DefaultHitEffectorType"
        case extraDamageRateInfoRowSet = "ExtraDamageRateInfoRowSet"
        case extraHitEffectorInfoSet = "ExtraHitEffectorInfoSet"
        case gameActor = "GameActor"
        case id = "Id"
        case isCoopRare = "IsCoopRare"
        case lObjParam = "LObjParam"
        case label = "Label"
        case lockerContentInfo = "LockerContentInfo"
        case matchingId = "MatchingId"
        case npcActor = "NpcActor"
        case range = "Range"
        case rewardLv2 = "RewardLv2"
        case rewardLv3 = "RewardLv3"
        case rewardLv4 = "RewardLv4"
        case rewardLv5 = "RewardLv5"
        case season = "Season"
        case shopPrice = "ShopPrice"
        case shopUnlockRank = "ShopUnlockRank"
        case specActor = "SpecActor"
        case specialPoint = "SpecialPoint"
        case specialWeapon = "SpecialWeapon"
        case subWeapon = "SubWeapon"
        case type = "Type"
        case uiParam = "UIParam"
        case weaponInfoForCoop = "WeaponInfoForCoop"
        case __rowId = "__RowId"
    }
}

extension WeaponInfoMain {
    
    public struct UIParam: Codable, Hashable {
        
        public let type: UIParamType
        public let value: Int
        
        public enum UIParamType: String, Codable, Hashable {
            case blaze = "Blaze"
            case charge = "Charge"
            case defence = "Defence"
            case explosion = "Explosion"
            case mobility = "Mobility"
            case paintSpeed = "PaintSpeed"
            case power = "Power"
            case range = "Range"
            case weight = "Weight"
        }
        
        enum CodingKeys: String, CodingKey {
            case type = "Type"
            case value = "Value"
        }
    }
}
