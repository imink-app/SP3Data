import Foundation

public extension WeaponInfoSpecial {
    
    static let allCases: [WeaponInfoSpecial] = {
        let jsonUrl = SP3Resources.extractedDataDir
            .appendingPathComponent("mush", isDirectory: true)
            .appendingPathComponent("WeaponInfoSpecial.json", isDirectory: false)
        let jsonData = try! Data(contentsOf: jsonUrl)
        let result = try! JSONDecoder().decode([WeaponInfoSpecial].self, from: jsonData)
        return result
    }()
    
    static let versusWeapons = allCases.filter { $0.type == .versus && $0.id != 20 }
    
    var localizedName: String? {
        let key = "CommonMsg/Weapon/WeaponName_Special/" + __rowId
        let value = Bundle.module.localizedString(forKey: key, value: nil, table: "Extracted")
        return value == key ? nil : value
    }
    
    func imageURL(style: WeaponImageStyle = .normal) -> URL? {
        let url: URL
        switch style {
        case .flat:
            url = SP3Resources.extractedImageDir
                .appendingPathComponent("subspe", isDirectory: true)
                .appendingPathComponent("Wsp_\(__rowId)00.png", isDirectory: false)
        case .badge00:
            url = SP3Resources.extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WinCount_WeaponSp_\(__rowId)_Lv00.png", isDirectory: false)
        case .badge01:
            url = SP3Resources.extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WinCount_WeaponSp_\(__rowId)_Lv01.png", isDirectory: false)
        case .badge02:
            url = SP3Resources.extractedImageDir
                .appendingPathComponent("badge", isDirectory: true)
                .appendingPathComponent("Badge_WinCount_WeaponSp_\(__rowId)_Lv02.png", isDirectory: false)
        default:
            return nil
        }
        return url.nilIfUnreachable()
    }
    
    static var supportedImageStyles: [WeaponImageStyle] {
        [.flat, .badge00, .badge01, .badge02]
    }
}

// MARK: - Generated Structure

public struct WeaponInfoSpecial: WeaponInfo, Codable, Hashable {
    public let defaultDamageRateInfoRow: DamageRateInfoRow
    public let defaultHitEffectorType: HitEffectorType
    public let extraDamageRateInfoRowSet: [DamageRate]
    public let extraHitEffectorInfoSet: [HitEffector]
    public let id: Int
    public let label: String
    public let npcActor: String
    public let specActor: String
    public let standAlone: Bool
    public let type: WeaponType
    public let __rowId: String

    enum CodingKeys: String, CodingKey {
        case defaultDamageRateInfoRow = "DefaultDamageRateInfoRow"
        case defaultHitEffectorType = "DefaultHitEffectorType"
        case extraDamageRateInfoRowSet = "ExtraDamageRateInfoRowSet"
        case extraHitEffectorInfoSet = "ExtraHitEffectorInfoSet"
        case id = "Id"
        case label = "Label"
        case npcActor = "NpcActor"
        case specActor = "SpecActor"
        case standAlone = "StandAlone"
        case type = "Type"
        case __rowId = "__RowId"
    }
}
