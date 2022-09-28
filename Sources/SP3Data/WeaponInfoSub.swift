import Foundation

public extension WeaponInfoSub {
    
    static let allCases: [WeaponInfoSub] = {
        let jsonUrl = extractedDataDir
            .appendingPathComponent("mush", isDirectory: true)
            .appendingPathComponent("WeaponInfoSub.json", isDirectory: false)
        let jsonData = try! Data(contentsOf: jsonUrl)
        let result = try! JSONDecoder().decode([WeaponInfoSub].self, from: jsonData)
        return result
    }()
    
    static let versusWeapons = allCases.filter { $0.type == .versus }
}

public extension WeaponInfoSub {
    
    var localizedName: String {
        let key = "CommonMsg/Weapon/WeaponName_Sub/" + __rowId
        return Bundle.module.localizedString(forKey: key, value: "[\(__rowId)]", table: "Extracted")
    }
    
    enum ImageStyle: CaseIterable {
        case normal
    }
    
    func imageURL(style: ImageStyle = .normal) -> URL? {
        let url: URL
        switch style {
        case .normal:
            url = extractedImageDir
                .appendingPathComponent("subspe", isDirectory: true)
                .appendingPathComponent("Wsb_\(__rowId)00.png", isDirectory: false)
        }
        return url.nilIfUnreachable()
    }
}

// MARK: - Generated Structure

public struct WeaponInfoSub: Codable, Hashable, CaseIterable {
    
    public let defaultDamageRateInfoRow: String
    public let defaultHitEffectorType: String
    public let extraDamageRateInfoRowSet: [DamageRate]
    public let extraHitEffectorInfoSet: [HitEffector]
    public let id: Int
    public let label: String
    public let lockerGoodsSubWeaponInfo: String
    public let npcActor: String
    public let specActor: String
    public let type: WeaponType
    public let __rowId: String

    enum CodingKeys: String, CodingKey {
        case defaultDamageRateInfoRow = "DefaultDamageRateInfoRow"
        case defaultHitEffectorType = "DefaultHitEffectorType"
        case extraDamageRateInfoRowSet = "ExtraDamageRateInfoRowSet"
        case extraHitEffectorInfoSet = "ExtraHitEffectorInfoSet"
        case id = "Id"
        case label = "Label"
        case lockerGoodsSubWeaponInfo = "LockerGoodsSubWeaponInfo"
        case npcActor = "NpcActor"
        case specActor = "SpecActor"
        case type = "Type"
        case __rowId = "__RowId"
    }
}
