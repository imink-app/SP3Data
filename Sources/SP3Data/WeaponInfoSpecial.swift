import Foundation

public extension WeaponInfoSpecial {
    
    static let allCases: [WeaponInfoSpecial] = {
        let jsonUrl = extractedDataDir
            .appendingPathComponent("mush", isDirectory: true)
            .appendingPathComponent("WeaponInfoSpecial.json", isDirectory: false)
        let jsonData = try! Data(contentsOf: jsonUrl)
        let result = try! JSONDecoder().decode([WeaponInfoSpecial].self, from: jsonData)
        return result
    }()
    
    static let versusWeapons = allCases.filter { $0.type == .versus }
}

public struct WeaponInfoSpecial: Codable, Hashable {
    public let defaultDamageRateInfoRow: String
    public let defaultHitEffectorType: String
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
