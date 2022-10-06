import Foundation
import SP3Data

struct AbilityChipTrio: RawRepresentable, Hashable, Codable, CaseIterable {
    
    var rawValue: UInt32
    
    var abilities: (Ability, Ability, Ability) {
        let a1 = Ability(rawValue: UInt8(0xff & rawValue))!
        let a2 = Ability(rawValue: UInt8(0xff & (rawValue >> 8)))!
        let a3 = Ability(rawValue: UInt8(0xff & (rawValue >> 16)))!
        return (a1, a2, a3)
    }
    
    init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    init(abilities: (Ability, Ability, Ability)) {
        rawValue = UInt32(abilities.0.rawValue) &
            UInt32(abilities.1.rawValue) << 8 &
            UInt32(abilities.2.rawValue) << 16
    }
    
    static var allCases: [AbilityChipTrio] = {
        var result: [AbilityChipTrio] = []
        for a1 in Ability.allCases {
            for a2 in Ability.allCases {
                for a3 in Ability.allCases {
                    result.append(AbilityChipTrio(abilities: (a1, a2, a3)))
                }
            }
        }
        return result
    }()
}

struct RollingTableItem: Hashable {
    
    var seed: AbilityRollingSeed
    var nextSeed: AbilityRollingSeed // store or calculate
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(seed)
    }
}

extension AbilityRollingSeed {
    
    mutating func nextTrio(brand: Brand) -> AbilityChipTrio {
        let a1 = nextAbility(brand: brand)
        let a2 = nextAbility(brand: brand)
        let a3 = nextAbility(brand: brand)
        return AbilityChipTrio(abilities: (a1, a2, a3))
    }
}

func brandTrioTable(brand: Brand) {
    var table: [AbilityChipTrio: [RollingTableItem]] = [:]
    for trio in AbilityChipTrio.allCases {
        table[trio] = []
    }
    for s in 0...(UInt32.max >> 12) {
        let seed = AbilityRollingSeed(rawValue: s)
        var nextSeed = seed
        let trio = nextSeed.nextTrio(brand: brand)
        let item = RollingTableItem(seed: seed, nextSeed: nextSeed)
        table[trio]!.append(item)
    }
}
