import Foundation
import seed_checker

public typealias Ability = seed_checker.Ability

extension Ability: SP3Localizable, SP3ImageGetting, CaseIterable {
    
    public var localizedName: String? {
        let key = "CommonMsg/Gear/GearPowerName/" + description
        let value = Bundle.module.localizedString(forKey: key, value: nil, table: "Extracted")
        return value == key ? nil : value
    }
    
    public func imageURL(style: SP3ImageStyle) -> URL? {
        guard style == .default else { return nil }
        return SP3Resources.extractedImageDir
            .appendingPathComponent("skill/\(description).png", isDirectory: false)
            .nilIfUnreachable()
    }
    
    public static let supportedImageStyles: [SP3ImageStyle] = [.default]
    
    public static let smallAbilities: [Ability] = (0..<Ability.smallAbilityCount.rawValue).map { Ability(rawValue: $0)! }
    public static let allCases: [Ability] = (0..<Ability.count.rawValue).map { Ability(rawValue: $0)! }
}

extension Ability: LosslessStringConvertible {
    
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
        case .openingGambit: return "StartAllUp"
        case .lastDitchEffort: return "EndAllUp"
        case .tenacity: return "MinorityUp"
        case .comeback: return "ComeBack"
        case .ninjaSquid: return "SquidMoveSpatter_Reduction"
        case .haunt: return "DeathMarking"
        case .thermalInk: return "ThermalInk"
        case .respawnPunisher: return "Exorcist"
        case .abilityDoubler: return "ExSkillDouble"
        case .stealthJump: return "SuperJumpSign_Hide"
        case .objectShredder: return "ObjectEffect_Up"
        case .dropRoller: return "SomersaultLanding"
        case .none: return "None"
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
        case "StartAllUp": self = .openingGambit
        case "EndAllUp": self = .lastDitchEffort
        case "MinorityUp": self = .tenacity
        case "ComeBack": self = .comeback
        case "SquidMoveSpatter_Reduction": self = .ninjaSquid
        case "DeathMarking": self = .haunt
        case "ThermalInk": self = .thermalInk
        case "Exorcist": self = .respawnPunisher
        case "ExSkillDouble": self = .abilityDoubler
        case "SuperJumpSign_Hide": self = .stealthJump
        case "ObjectEffect_Up": self = .objectShredder
        case "SomersaultLanding": self = .dropRoller
        case "None": self = .none
        default: return nil
        }
    }
}

extension Ability: Codable {
    
    public func encode(to encoder: Encoder) throws {
        try description.encode(to: encoder)
    }
    
    public init(from decoder: Decoder) throws {
        let str = try String(from: decoder)
        guard let result = Ability(str) else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "invalid Ability"))
        }
        self = result
    }
}
