import Foundation
import SeedChecker

public typealias AbilityChip = SeedChecker.Ability

public extension AbilityChip {
    
    var localizedName: String? {
        let key = "CommonMsg/Gear/GearPowerName/" + description
        let value = Bundle.module.localizedString(forKey: key, value: nil, table: "Extracted")
        return value == key ? nil : value
    }
    
    var imageURL: URL? {
        return SP3Resources.extractedImageDir
            .appendingPathComponent("skill/\(description).png", isDirectory: false)
            .nilIfUnreachable()
    }
}

extension AbilityChip: CaseIterable {
    
    public static var allCases: [AbilityChip] = (0..<AbilityChip.count.rawValue).map { Ability(rawValue: $0)! }
}

extension AbilityChip: LosslessStringConvertible {
    
    public var description: String {
        switch self {
        case .inkSaverMain: return "MainInk_Save"
        case .inkSaverSub: return "SubInk_Save"
        case .inkRecoveryUp: return "InkRecovery_Up"
        case .runSpeedUp: return "HumanMove_Up"
        case .swimSpeedUp: return "SquidMove_Up"
        case .specialChargeUp: return "SpecialIncrease_Up"
        case .specialSaver: return "RespawnSpecialGauge_Save"
        case .specialPowerUp: return "SpecialSpec_Up"
        case .quickRespawn: return "RespawnTime_Save"
        case .quickSuperJump: return "JumpTime_Save"
        case .subPowerUp: return "SubSpec_Up"
        case .inkResistanceUp: return "OpInkEffect_Reduction"
        case .subResistanceUp: return "SubEffect_Reduction"
        case .intensifyAction: return "Action_Up"
        default: return "Ability[\(rawValue)]"
        }
    }
    
    public init?(_ description: String) {
        switch description {
        case "MainInk_Save": self = .inkSaverMain
        case "SubInk_Save": self = .inkSaverSub
        case "InkRecovery_Up": self = .inkRecoveryUp
        case "HumanMove_Up": self = .runSpeedUp
        case "SquidMove_Up": self = .swimSpeedUp
        case "SpecialIncrease_Up": self = .specialChargeUp
        case "RespawnSpecialGauge_Save": self = .specialSaver
        case "SpecialSpec_Up": self = .specialPowerUp
        case "RespawnTime_Save": self = .quickRespawn
        case "JumpTime_Save": self = .quickSuperJump
        case "SubSpec_Up": self = .subPowerUp
        case "OpInkEffect_Reduction": self = .inkResistanceUp
        case "SubEffect_Reduction": self = .subResistanceUp
        case "Action_Up": self = .intensifyAction
        default: return nil
        }
    }
}

extension AbilityChip: Codable {
    
    public func encode(to encoder: Encoder) throws {
        try description.encode(to: encoder)
    }
    
    public init(from decoder: Decoder) throws {
        let str = try String(from: decoder)
        guard let result = AbilityChip(str) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "invalid AbilityChip"))
        }
        self = result
    }
}
