import Foundation
@_implementationOnly import SeedChecker

public struct AbilityRollingSeed: RawRepresentable, Hashable, Codable, Comparable, ExpressibleByIntegerLiteral {
    
    public var rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    public init(integerLiteral value: UInt32) {
        self.init(rawValue: value)
    }
    
    public static func < (lhs: AbilityRollingSeed, rhs: AbilityRollingSeed) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public mutating func nextAbility(brand: Brand, drink: AbilityChip? = nil) -> AbilityChip {
        let scb = get_ability(rawValue, brand.scBrand!, drink?.scAbility ?? .noDrink).ability
        return AbilityChip(scAbility: scb)
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
            var currentSeed: SCRollingSeed?
            
            init(sequence: SearchSequence) {
                self.sequence = sequence
                currentSeed = sequence.range.lowerBound.rawValue
            }
            
            public mutating func next() -> AbilityRollingSeed? {
                guard let currentSeed = currentSeed else { return nil }
                var abilities = sequence.abilities.map(\.scAbility)
                let seed = search_seed(currentSeed, sequence.range.upperBound.rawValue, sequence.brand.scBrand!, &abilities, Int32(abilities.count))
                if seed == SCRollingSeed_Invalid {
                    self.currentSeed = nil
                    return nil
                } else if seed == sequence.range.upperBound.rawValue {
                    self.currentSeed = nil
                    return AbilityRollingSeed(rawValue: seed)
                } else {
                    self.currentSeed = seed + 1
                    return AbilityRollingSeed(rawValue: seed)
                }
            }
        }
        
        public func makeIterator() -> Iterator {
            Iterator(sequence: self)
        }
    }
}

private extension SCAbility {
    static var noDrink: SCAbility {
        return SCAbility(UInt8(SCAbility_NoDrink))
    }
}

private extension AbilityChip {
    
    var scAbility: SCAbility {
        return SCAbility(rawValue: rawValue)
    }
    
    init(scAbility: SCAbility) {
        self.init(rawValue: scAbility.rawValue)!
    }
}

private extension Brand {
    
    static var scBrandTable: [Brand: SCBrand] = {
        var result: [Brand: SCBrand] = [:]
        for i in 0..<SCBrand_Count.rawValue {
            let scb = SCBrand(rawValue: i)
            let b = Brand(scBrand: scb)
            result[b] = scb
        }
        return result
    }()
    
    var scBrand: SCBrand? {
        return Brand.scBrandTable[self]
    }
    
    init(scBrand: SCBrand) {
        self.init(rawValue: brand_code(scBrand))
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
