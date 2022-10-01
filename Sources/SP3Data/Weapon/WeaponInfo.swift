import Foundation

public protocol WeaponInfo: CaseIterable, CustomDebugStringConvertible {
    var __rowId: String { get }
    var id: Int { get }
    var type: WeaponType { get }
    var label: String { get }
    var specActor: String { get }
    var defaultDamageRateInfoRow: DamageRateInfoRow { get }
    var defaultHitEffectorType: HitEffectorType { get }
    var extraDamageRateInfoRowSet: [DamageRate] { get }
    var extraHitEffectorInfoSet: [HitEffector] { get }
    
    var localizedName: String? { get }
    func imageURL(style: WeaponImageStyle) -> URL?
    static var supportedImageStyles: [WeaponImageStyle] { get }
    
    static var versusWeapons: [Self] { get }
    static var coopWeapons: [Self] { get }
}

public extension WeaponInfo {
    
    var debugDescription: String {
        let weaponType: String
        switch self {
        case is WeaponInfoMain:
            weaponType = "MainWeapon"
        case is WeaponInfoSub:
            weaponType = "SubWeapon"
        case is WeaponInfoSpecial:
            weaponType = "SpecialWeapon"
        default:
            weaponType = "Weapon"
        }
        return "\(weaponType) \(__rowId) [\(localizedName ?? label)]"
    }
    
    static var versusWeapons: [Self] {
        return allCases.filter { $0.type == .versus }
    }
    
    static var coopWeapons: [Self] {
        return allCases.filter { $0.type == .coop }
    }
}

public enum WeaponImageStyle {
    case normal
    case flat
    case badge00
    case badge01
    case badge02
    case sticker00
    /// shining sticker
    case sticker01
}

public enum WeaponType: String, Codable, Hashable {
    case coop = "Coop"
    case mission = "Mission"
    case other = "Other"
    case rival = "Rival"
    case versus = "Versus"
}

public struct DamageRate: Codable, Hashable {
    
    public let damageRateInfoRow: DamageRateInfoRow
    public let extraInfo: String
    
    enum CodingKeys: String, CodingKey {
        case damageRateInfoRow = "DamageRateInfoRow"
        case extraInfo = "ExtraInfo"
    }
}

public struct HitEffector: Codable, Hashable {
    
    public let hitEffectorType: HitEffectorType
    public let extraInfo: String
    
    enum CodingKeys: String, CodingKey {
        case hitEffectorType = "HitEffectorType"
        case extraInfo = "ExtraInfo"
    }
}

public struct DamageRateInfoRow: RawRepresentable, Hashable, Codable, CaseIterable {
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public struct HitEffectorType: RawRepresentable, Hashable, Codable, CaseIterable {
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension DamageRateInfoRow {
    static let blaster = DamageRateInfoRow(rawValue: "Blaster")
    static let blasterBlasterMiddle = DamageRateInfoRow(rawValue: "Blaster_BlasterMiddle")
    static let blasterBlasterShort = DamageRateInfoRow(rawValue: "Blaster_BlasterShort")
    static let blasterKillOneShot = DamageRateInfoRow(rawValue: "Blaster_KillOneShot")
    static let blowerExhale = DamageRateInfoRow(rawValue: "BlowerExhale")
    static let blowerExhaleBombCore = DamageRateInfoRow(rawValue: "BlowerExhale_BombCore")
    static let blowerInhale = DamageRateInfoRow(rawValue: "BlowerInhale")
    static let bomb = DamageRateInfoRow(rawValue: "Bomb")
    static let bombCurlingBullet = DamageRateInfoRow(rawValue: "Bomb_CurlingBullet")
    static let bombDirectHit = DamageRateInfoRow(rawValue: "Bomb_DirectHit")
    static let bombFizzy = DamageRateInfoRow(rawValue: "Bomb_Fizzy")
    static let bombSuction = DamageRateInfoRow(rawValue: "Bomb_Suction")
    static let bombTorpedoBullet = DamageRateInfoRow(rawValue: "Bomb_TorpedoBullet")
    static let bombTorpedoSplashBurst = DamageRateInfoRow(rawValue: "Bomb_TorpedoSplashBurst")
    static let bombTrap = DamageRateInfoRow(rawValue: "Bomb_Trap")
    static let brushCore = DamageRateInfoRow(rawValue: "BrushCore")
    static let brushSplash = DamageRateInfoRow(rawValue: "BrushSplash")
    static let charger = DamageRateInfoRow(rawValue: "Charger")
    static let chargerFull = DamageRateInfoRow(rawValue: "ChargerFull")
    static let chargerFullLight = DamageRateInfoRow(rawValue: "ChargerFull_Light")
    static let chargerFullLong = DamageRateInfoRow(rawValue: "ChargerFull_Long")
    static let chargerLight = DamageRateInfoRow(rawValue: "Charger_Light")
    static let chargerLong = DamageRateInfoRow(rawValue: "Charger_Long")
    static let chariotBody = DamageRateInfoRow(rawValue: "Chariot_Body")
    static let chariotCannon = DamageRateInfoRow(rawValue: "Chariot_Cannon")
    static let `default` = DamageRateInfoRow(rawValue: "Default")
    static let gachihokoBombCore = DamageRateInfoRow(rawValue: "Gachihoko_BombCore")
    static let gachihokoBullet = DamageRateInfoRow(rawValue: "Gachihoko_Bullet")
    static let inkStorm = DamageRateInfoRow(rawValue: "InkStorm")
    static let inkStormRain = DamageRateInfoRow(rawValue: "InkStormRain")
    static let jetpackBombCore = DamageRateInfoRow(rawValue: "Jetpack_BombCore")
    static let jetpackBullet = DamageRateInfoRow(rawValue: "Jetpack_Bullet")
    static let jetpackCoop = DamageRateInfoRow(rawValue: "Jetpack_Coop")
    static let jetpackJet = DamageRateInfoRow(rawValue: "Jetpack_Jet")
    static let maneuver = DamageRateInfoRow(rawValue: "Maneuver")
    static let maneuverShort = DamageRateInfoRow(rawValue: "Maneuver_Short")
    static let microLaser = DamageRateInfoRow(rawValue: "MicroLaser")
    static let multiMissileBombCore = DamageRateInfoRow(rawValue: "MultiMissile_BombCore")
    static let multiMissileBullet = DamageRateInfoRow(rawValue: "MultiMissile_Bullet")
    static let niceBall = DamageRateInfoRow(rawValue: "NiceBall")
    static let rollerCore = DamageRateInfoRow(rawValue: "RollerCore")
    static let rollerSplash = DamageRateInfoRow(rawValue: "RollerSplash")
    static let rollerSplashCompact = DamageRateInfoRow(rawValue: "RollerSplash_Compact")
    static let rollerSplashHeavy = DamageRateInfoRow(rawValue: "RollerSplash_Heavy")
    static let rollerSplashHunter = DamageRateInfoRow(rawValue: "RollerSplash_Hunter")
    static let saber = DamageRateInfoRow(rawValue: "Saber")
    static let saberChargeShot = DamageRateInfoRow(rawValue: "Saber_ChargeShot")
    static let saberChargeSlash = DamageRateInfoRow(rawValue: "Saber_ChargeSlash")
    static let saberShot = DamageRateInfoRow(rawValue: "Saber_Shot")
    static let saberSlash = DamageRateInfoRow(rawValue: "Saber_Slash")
    static let shelterCanopy = DamageRateInfoRow(rawValue: "ShelterCanopy")
    static let shelterCanopyCompact = DamageRateInfoRow(rawValue: "ShelterCanopy_Compact")
    static let shelterCanopyWide = DamageRateInfoRow(rawValue: "ShelterCanopy_Wide")
    static let shelterShot = DamageRateInfoRow(rawValue: "ShelterShot")
    static let shelterShotCompact = DamageRateInfoRow(rawValue: "ShelterShot_Compact")
    static let shelterShotWide = DamageRateInfoRow(rawValue: "ShelterShot_Wide")
    static let shield = DamageRateInfoRow(rawValue: "Shield")
    static let shockSonarWave = DamageRateInfoRow(rawValue: "ShockSonar_Wave")
    static let shooter = DamageRateInfoRow(rawValue: "Shooter")
    static let shooterBlaze = DamageRateInfoRow(rawValue: "Shooter_Blaze")
    static let shooterExpert = DamageRateInfoRow(rawValue: "Shooter_Expert")
    static let shooterFirst = DamageRateInfoRow(rawValue: "Shooter_First")
    static let shooterFlash = DamageRateInfoRow(rawValue: "Shooter_Flash")
    static let shooterFlashRepeat = DamageRateInfoRow(rawValue: "Shooter_FlashRepeat")
    static let shooterGravity = DamageRateInfoRow(rawValue: "Shooter_Gravity")
    static let shooterHeavy = DamageRateInfoRow(rawValue: "Shooter_Heavy")
    static let shooterLong = DamageRateInfoRow(rawValue: "Shooter_Long")
    static let shooterPrecision = DamageRateInfoRow(rawValue: "Shooter_Precision")
    static let shooterShort = DamageRateInfoRow(rawValue: "Shooter_Short")
    static let shooterTripleMiddle = DamageRateInfoRow(rawValue: "Shooter_TripleMiddle")
    static let shooterTripleQuick = DamageRateInfoRow(rawValue: "Shooter_TripleQuick")
    static let skewer = DamageRateInfoRow(rawValue: "Skewer")
    static let skewerBody = DamageRateInfoRow(rawValue: "Skewer_Body")
    static let slosher = DamageRateInfoRow(rawValue: "Slosher")
    static let slosherBathtub = DamageRateInfoRow(rawValue: "Slosher_Bathtub")
    static let slosherBear = DamageRateInfoRow(rawValue: "Slosher_Bear")
    static let slosherWashtub = DamageRateInfoRow(rawValue: "Slosher_Washtub")
    static let slosherWashtubBombCore = DamageRateInfoRow(rawValue: "Slosher_WashtubBombCore")
    static let spinner = DamageRateInfoRow(rawValue: "Spinner")
    static let sprinkler = DamageRateInfoRow(rawValue: "Sprinkler")
    static let stringer = DamageRateInfoRow(rawValue: "Stringer")
    static let stringerShort = DamageRateInfoRow(rawValue: "Stringer_Short")
    static let superHook = DamageRateInfoRow(rawValue: "SuperHook")
    static let superLanding = DamageRateInfoRow(rawValue: "SuperLanding")
    static let tripleTornado = DamageRateInfoRow(rawValue: "TripleTornado")
    static let ultraShot = DamageRateInfoRow(rawValue: "UltraShot")
    static let ultraStampSwing = DamageRateInfoRow(rawValue: "UltraStamp_Swing")
    static let ultraStampThrow = DamageRateInfoRow(rawValue: "UltraStamp_Throw")
    static let ultraStampThrowBombCore = DamageRateInfoRow(rawValue: "UltraStamp_Throw_BombCore")
    
    static let allCases: [DamageRateInfoRow] = [
        .blaster,
        .blasterBlasterMiddle,
        .blasterBlasterShort,
        .blasterKillOneShot,
        .blowerExhale,
        .blowerExhaleBombCore,
        .blowerInhale,
        .bomb,
        .bombCurlingBullet,
        .bombDirectHit,
        .bombFizzy,
        .bombSuction,
        .bombTorpedoBullet,
        .bombTorpedoSplashBurst,
        .bombTrap,
        .brushCore,
        .brushSplash,
        .charger,
        .chargerFull,
        .chargerFullLight,
        .chargerFullLong,
        .chargerLight,
        .chargerLong,
        .chariotBody,
        .chariotCannon,
        .default,
        .gachihokoBombCore,
        .gachihokoBullet,
        .inkStorm,
        .inkStormRain,
        .jetpackBombCore,
        .jetpackBullet,
        .jetpackCoop,
        .jetpackJet,
        .maneuver,
        .maneuverShort,
        .microLaser,
        .multiMissileBombCore,
        .multiMissileBullet,
        .niceBall,
        .rollerCore,
        .rollerSplash,
        .rollerSplashCompact,
        .rollerSplashHeavy,
        .rollerSplashHunter,
        .saber,
        .saberChargeShot,
        .saberChargeSlash,
        .saberShot,
        .saberSlash,
        .shelterCanopy,
        .shelterCanopyCompact,
        .shelterCanopyWide,
        .shelterShot,
        .shelterShotCompact,
        .shelterShotWide,
        .shield,
        .shockSonarWave,
        .shooter,
        .shooterBlaze,
        .shooterExpert,
        .shooterFirst,
        .shooterFlash,
        .shooterFlashRepeat,
        .shooterGravity,
        .shooterHeavy,
        .shooterLong,
        .shooterPrecision,
        .shooterShort,
        .shooterTripleMiddle,
        .shooterTripleQuick,
        .skewer,
        .skewerBody,
        .slosher,
        .slosherBathtub,
        .slosherBear,
        .slosherWashtub,
        .slosherWashtubBombCore,
        .spinner,
        .sprinkler,
        .stringer,
        .stringerShort,
        .superHook,
        .superLanding,
        .tripleTornado,
        .ultraShot,
        .ultraStampSwing,
        .ultraStampThrow,
        .ultraStampThrowBombCore,
    ]
}

public extension HitEffectorType {
    static let blaster = HitEffectorType(rawValue: "Blaster")
    static let blasterExtraBombCore = HitEffectorType(rawValue: "Blaster_ExtraBombCore")
    static let blasterExtraBombCoreWeak = HitEffectorType(rawValue: "Blaster_ExtraBombCoreWeak")
    static let blowerInhale = HitEffectorType(rawValue: "Blower_Inhale")
    static let bomb = HitEffectorType(rawValue: "Bomb")
    static let bombCurling = HitEffectorType(rawValue: "Bomb_Curling")
    static let bombFizzy = HitEffectorType(rawValue: "Bomb_Fizzy")
    static let bombTorpedo = HitEffectorType(rawValue: "Bomb_Torpedo")
    static let charger = HitEffectorType(rawValue: "Charger")
    static let chargerFullCharge = HitEffectorType(rawValue: "Charger_FullCharge")
    static let chargerPaintSplash = HitEffectorType(rawValue: "Charger_PaintSplash")
    static let `default` = HitEffectorType(rawValue: "Default")
    static let inkStorm = HitEffectorType(rawValue: "InkStorm")
    static let jetpackLauncher = HitEffectorType(rawValue: "Jetpack_Launcher")
    static let lineMarker = HitEffectorType(rawValue: "LineMarker")
    static let maneuver = HitEffectorType(rawValue: "Maneuver")
    static let multiMissileBombCore = HitEffectorType(rawValue: "MultiMissile_BombCore")
    static let multiMissileBullet = HitEffectorType(rawValue: "MultiMissile_Bullet")
    static let niceBall = HitEffectorType(rawValue: "NiceBall")
    static let roller = HitEffectorType(rawValue: "Roller")
    static let rollerNoDamage = HitEffectorType(rawValue: "Roller_NoDamage")
    static let saber = HitEffectorType(rawValue: "Saber")
    static let saberChargeShot = HitEffectorType(rawValue: "Saber_ChargeShot")
    static let saberChargeSlash = HitEffectorType(rawValue: "Saber_ChargeSlash")
    static let saberShot = HitEffectorType(rawValue: "Saber_Shot")
    static let saberSlash = HitEffectorType(rawValue: "Saber_Slash")
    static let salmonBuddy = HitEffectorType(rawValue: "SalmonBuddy")
    static let shelter = HitEffectorType(rawValue: "Shelter")
    static let shelterCanopy = HitEffectorType(rawValue: "Shelter_Canopy")
    static let shockSonarWave = HitEffectorType(rawValue: "ShockSonar_Wave")
    static let shooter = HitEffectorType(rawValue: "Shooter")
    static let shooterCriticalHit = HitEffectorType(rawValue: "Shooter_CriticalHit")
    static let skewerBombCore = HitEffectorType(rawValue: "Skewer_BombCore")
    static let slosher = HitEffectorType(rawValue: "Slosher")
    static let slosherBathtub = HitEffectorType(rawValue: "Slosher_Bathtub")
    static let slosherBearLeader = HitEffectorType(rawValue: "Slosher_BearLeader")
    static let slosherBig = HitEffectorType(rawValue: "Slosher_Big")
    static let slosherLauncherFollower = HitEffectorType(rawValue: "Slosher_LauncherFollower")
    static let slosherLauncherLeader = HitEffectorType(rawValue: "Slosher_LauncherLeader")
    static let slosherWashtubBombCore = HitEffectorType(rawValue: "Slosher_WashtubBombCore")
    static let spinner = HitEffectorType(rawValue: "Spinner")
    static let sprinkler = HitEffectorType(rawValue: "Sprinkler")
    static let sprinklerInk = HitEffectorType(rawValue: "Sprinkler_Ink")
    static let superLanding = HitEffectorType(rawValue: "SuperLanding")
    static let ultraShot = HitEffectorType(rawValue: "UltraShot")
    static let ultraStamp = HitEffectorType(rawValue: "UltraStamp")
    
    static let allCases: [HitEffectorType] = [
        .blaster,
        .blasterExtraBombCore,
        .blasterExtraBombCoreWeak,
        .blowerInhale,
        .bomb,
        .bombCurling,
        .bombFizzy,
        .bombTorpedo,
        .charger,
        .chargerFullCharge,
        .chargerPaintSplash,
        .default,
        .inkStorm,
        .jetpackLauncher,
        .lineMarker,
        .maneuver,
        .multiMissileBombCore,
        .multiMissileBullet,
        .niceBall,
        .roller,
        .rollerNoDamage,
        .saber,
        .saberChargeShot,
        .saberChargeSlash,
        .saberShot,
        .saberSlash,
        .salmonBuddy,
        .shelter,
        .shelterCanopy,
        .shockSonarWave,
        .shooter,
        .shooterCriticalHit,
        .skewerBombCore,
        .slosher,
        .slosherBathtub,
        .slosherBearLeader,
        .slosherBig,
        .slosherLauncherFollower,
        .slosherLauncherLeader,
        .slosherWashtubBombCore,
        .spinner,
        .sprinkler,
        .sprinklerInk,
        .superLanding,
        .ultraShot,
        .ultraStamp,
    ]
}
