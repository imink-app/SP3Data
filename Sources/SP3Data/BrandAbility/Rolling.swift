import Foundation
import SeedChecker

public typealias AbilityRollingSeed = SeedChecker.AbilityRollingSeed

extension AbilityRollingSeed: Codable, Comparable, ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt32) {
        self.init(rawValue: value)
    }
    
    public static func < (lhs: AbilityRollingSeed, rhs: AbilityRollingSeed) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public mutating func nextAbility(brand: Brand, drink: AbilityChip? = nil) -> AbilityChip {
        return get_ability(self, brand, drink ?? .noDrink).ability
    }
    
    public static func search(brand: Brand, abilities: [AbilityChip], in range: ClosedRange<AbilityRollingSeed>) -> SearchSequence {
        SearchSequence(brand: brand, abilities: abilities, range: range)
    }
    
    public struct SearchSequence: Sequence {
        
        let brand: Brand
        let abilities: [AbilityChip]
        let range: ClosedRange<AbilityRollingSeed>
        
        public struct Iterator: IteratorProtocol {
            let sequence: SearchSequence
            var currentSeed: AbilityRollingSeed?
            
            init(sequence: SearchSequence) {
                self.sequence = sequence
                currentSeed = sequence.range.lowerBound
            }
            
            public mutating func next() -> AbilityRollingSeed? {
                guard let currentSeed = currentSeed else { return nil }
                var abilities = sequence.abilities
                let seed = search_seed_in_range(currentSeed, sequence.range.upperBound, sequence.brand, &abilities, abilities.count)
                if seed == .invalid {
                    self.currentSeed = nil
                    return nil
                } else if seed == sequence.range.upperBound {
                    self.currentSeed = nil
                    return seed
                } else {
                    self.currentSeed = AbilityRollingSeed(seed.rawValue + 1)
                    return seed
                }
            }
        }
        
        public func makeIterator() -> Iterator {
            Iterator(sequence: self)
        }
    }
}

// MARK: -

#if false

extension AbilityRollingSeed {
    
    public mutating func advance() {
        rawValue ^= rawValue << 13
        rawValue ^= rawValue >> 17
        rawValue ^= rawValue << 5
    }
    
    public mutating func nextAbility(brand: Brand, drink: AbilityChip? = nil) -> AbilityChip {
        if let drink = drink {
            advance()
            if(rawValue % 0x64 <= 0x1D) {
                return drink
            }
            advance()
            let table = brand.rollingTable(drink: drink)
            let roll = rawValue % UInt32(table.count)
            return table[Int(roll)]
        } else {
            advance()
            let table = brand.rollingTable(drink: nil)
            let roll = rawValue % UInt32(table.count)
            return table[Int(roll)]
        }
    }
}

public extension Brand {
    
    func rollingWeight(for ability: AbilityChip) -> Int {
        switch ability {
        case usualGearSkill: return _BrandTraitsInfo.shared.skillEasilyToGetParam[2]
        case unusualGearSkill: return _BrandTraitsInfo.shared.skillEasilyToGetParam[0]
        default: return _BrandTraitsInfo.shared.skillEasilyToGetParam[1]
        }
    }
    
    func rollingTable(drink: AbilityChip?) -> [AbilityChip] {
        return Brand.rollingTables[self]![drink]!
    }
    
    static let rollingTables: [Brand: [AbilityChip?: [AbilityChip]]] = {
        var result: [Brand: [AbilityChip?: [AbilityChip]]] = [:]
        for brand in Brand.allCases {
            var brandTable: [AbilityChip?: [AbilityChip]] = [:]
            brandTable[nil] = []
            for drinkAbility in AbilityChip.allCases {
                var drinkTable: [AbilityChip] = []
                for ability in AbilityChip.allCases where drinkAbility != ability {
                    drinkTable.append(contentsOf: Array(repeating: ability, count: brand.rollingWeight(for: ability)))
                }
                brandTable[nil]!.append(contentsOf: Array(repeating: drinkAbility, count: brand.rollingWeight(for: drinkAbility)))
                brandTable[drinkAbility] = drinkTable
            }
            result[brand] = brandTable
        }
        return result
    }()
}

#endif
