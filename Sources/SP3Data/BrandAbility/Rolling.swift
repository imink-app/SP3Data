import Foundation
import seed_checker

public typealias AbilityRollingSeed = seed_checker.AbilityRollingSeed

extension AbilityRollingSeed: Codable, Comparable, ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt32) {
        self.init(rawValue: value)
    }
    
    public static func < (lhs: AbilityRollingSeed, rhs: AbilityRollingSeed) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public mutating func nextAbility(brand: Brand, drink: Ability? = nil) -> Ability {
        return get_ability(self, brand, drink ?? .none).ability
    }
    
    public static func search(brand: Brand, abilities: [Ability], in range: ClosedRange<AbilityRollingSeed>) -> SearchSequence {
        SearchSequence(brand: brand, abilities: abilities, range: range)
    }
    
    public struct SearchSequence: Sequence {
        
        let brand: Brand
        let abilities: [Ability]
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
    
    public mutating func nextAbility(brand: Brand, drink: Ability? = nil) -> Ability {
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
    
    func rollingWeight(for ability: Ability) -> Int {
        switch ability {
        case usualGearSkill: return _BrandTraitsInfo.shared.skillEasilyToGetParam[2]
        case unusualGearSkill: return _BrandTraitsInfo.shared.skillEasilyToGetParam[0]
        default: return _BrandTraitsInfo.shared.skillEasilyToGetParam[1]
        }
    }
    
    func rollingTable(drink: Ability?) -> [Ability] {
        return Brand.rollingTables[self]![drink]!
    }
    
    static let rollingTables: [Brand: [Ability?: [Ability]]] = {
        var result: [Brand: [Ability?: [Ability]]] = [:]
        for brand in Brand.allCases {
            var brandTable: [Ability?: [Ability]] = [:]
            brandTable[nil] = []
            for drinkAbility in Ability.allCases {
                var drinkTable: [Ability] = []
                for ability in Ability.allCases where drinkAbility != ability {
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
