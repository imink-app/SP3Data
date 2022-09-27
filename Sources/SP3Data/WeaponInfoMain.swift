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
    
    static let versusWeapons = allCases.filter { $0.type == .versus }
}

public extension WeaponInfoMain {
    
    var localizedName: String {
        let key = "CommonMsg/Weapon/WeaponName_Main/" + rowId
        return Bundle.module.localizedString(forKey: key, value: "[\(rowId)]", table: "Extracted")
    }
    
    enum WeaponImageStyle: CaseIterable {
        case normal
        case flat
        case badge00
        case badge01
        case sticker00
        /// shining sticker
        case sticker01
    }
    
    func imageURL(style: WeaponImageStyle) -> URL? {
        let url: URL
        switch style {
        case .normal:
            url = extractedImageDir
                .appendingPathComponent("weapon", isDirectory: true)
                .appendingPathComponent("Wst_\(rowId).png", isDirectory: false)
        case .flat:
            url = extractedImageDir
                .appendingPathComponent("weapon_flat", isDirectory: true)
                .appendingPathComponent("Path_Wst_\(rowId).png", isDirectory: false)
        case .badge00:
            url = extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WeaponLevel_\(rowId)_Lv00.png", isDirectory: false)
        case .badge01:
            url = extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WeaponLevel_\(rowId)_Lv01.png", isDirectory: false)
        case .sticker00:
            url = extractedImageDir
                .appendingPathComponent("zakka", isDirectory: true)
                .appendingPathComponent("Stc_Sti_Wst_\(rowId)_Lv00.png", isDirectory: false)
        case .sticker01:
            url = extractedImageDir
                .appendingPathComponent("zakka", isDirectory: true)
                .appendingPathComponent("Hla_Sti_Wst_\(rowId)_Lv01.png", isDirectory: false)
        }
        if (try? url.checkResourceIsReachable()) == true {
            return url
        } else {
            return nil
        }
    }
}

// MARK: - Generated Structure

public struct WeaponInfoMain: Codable, Hashable, CaseIterable {
    
    public let debugDispColumn: Int
    public let debugDispOrder: Int
    public let defaultDamageRateInfoRow: String
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
    public let rowId: String
    
    public enum HitEffectorType: String, Codable, Hashable {
        case blaster = "Blaster"
        case charger = "Charger"
        case defaultHitEffectorTypeDefault = "Default"
        case maneuver = "Maneuver"
        case roller = "Roller"
        case saber = "Saber"
        case shelter = "Shelter"
        case shooter = "Shooter"
        case slosher = "Slosher"
        case slosherBathtub = "Slosher_Bathtub"
        case slosherBearLeader = "Slosher_BearLeader"
        case slosherLauncherLeader = "Slosher_LauncherLeader"
        case spinner = "Spinner"
    }
    
    public enum WeaponType: String, Codable, Hashable {
        case coop = "Coop"
        case mission = "Mission"
        case other = "Other"
        case rival = "Rival"
        case versus = "Versus"
    }

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
        case rowId = "__RowId"
    }
}

extension WeaponInfoMain {
    
    public struct DamageRate: Codable, Hashable {
        
        public let damageRateInfoRow: String
        public let extraInfo: ExtraInfo
        
        public enum ExtraInfo: String, Codable, Hashable {
            case blasterWeakBlast = "BlasterWeakBlast"
            case extraBombCore = "ExtraBombCore"
            case fullCharge = "FullCharge"
            case normal = "Normal"
            case rollerCore = "RollerCore"
            case saberChargeShot = "SaberChargeShot"
            case saberChargeSlash = "SaberChargeSlash"
            case saberShot = "SaberShot"
            case saberSlash = "SaberSlash"
            case shelterCanopy = "ShelterCanopy"
            case shooterVariableRepeat = "ShooterVariableRepeat"
        }
        
        enum CodingKeys: String, CodingKey {
            case damageRateInfoRow = "DamageRateInfoRow"
            case extraInfo = "ExtraInfo"
        }
    }
    
    public struct HitEffector: Codable, Hashable {
        
        public let extraInfo: String
        public let hitEffectorType: String
        
        enum CodingKeys: String, CodingKey {
            case extraInfo = "ExtraInfo"
            case hitEffectorType = "HitEffectorType"
        }
    }
    
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
