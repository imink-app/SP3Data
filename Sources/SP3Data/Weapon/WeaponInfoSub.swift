import Foundation

public extension WeaponInfoSub {
    
    static let allCases: [WeaponInfoSub] = {
        let jsonUrl = SP3Resources.extractedDataDir
            .appendingPathComponent("mush", isDirectory: true)
            .appendingPathComponent("WeaponInfoSub.json", isDirectory: false)
        let jsonData = try! Data(contentsOf: jsonUrl)
        let result = try! JSONDecoder().decode([WeaponInfoSub].self, from: jsonData)
        return result
    }()
    
    var localizedName: String? {
        let key = "CommonMsg/Weapon/WeaponName_Sub/" + __rowId
        let value = Bundle.module.localizedString(forKey: key, value: nil, table: "Extracted")
        return value == key ? nil : value
    }
    
    func imageURL(style: SP3ImageStyle = .default) -> URL? {
        let url: URL
        switch style {
        case .default:
            url = SP3Resources.extractedImageDir
                .appendingPathComponent("weapon", isDirectory: true)
                .appendingPathComponent("Wst_\(__rowId).png", isDirectory: false)
        case .flat:
            url = SP3Resources.extractedImageDir
                .appendingPathComponent("subspe", isDirectory: true)
                .appendingPathComponent("Wsb_\(__rowId)00.png", isDirectory: false)
        default:
            return nil
        }
        return url.nilIfUnreachable()
    }
    
    static var supportedImageStyles: [SP3ImageStyle] {
        return [.default, .flat]
    }
}

// MARK: - Generated Structure

public struct WeaponInfoSub: WeaponInfo, Codable, Hashable, CaseIterable {
    
    public let defaultDamageRateInfoRow: DamageRateInfoRow
    public let defaultHitEffectorType: HitEffectorType
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
