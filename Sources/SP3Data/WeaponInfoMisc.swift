import Foundation

public enum WeaponType: String, Codable, Hashable {
    case coop = "Coop"
    case mission = "Mission"
    case other = "Other"
    case rival = "Rival"
    case versus = "Versus"
}

public struct DamageRate: Codable, Hashable {
    
    public let damageRateInfoRow: String
    public let extraInfo: String
    
    enum CodingKeys: String, CodingKey {
        case damageRateInfoRow = "DamageRateInfoRow"
        case extraInfo = "ExtraInfo"
    }
}

public struct HitEffector: Codable, Hashable {
    
    public let hitEffectorType: String
    public let extraInfo: String
    
    enum CodingKeys: String, CodingKey {
        case hitEffectorType = "HitEffectorType"
        case extraInfo = "ExtraInfo"
    }
}
