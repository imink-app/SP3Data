import Foundation

public extension Brand {
    
    var usualGearSkill: Ability? {
        _BrandTraitsInfo.shared.traits[self]?.usualGearSkill
    }
    
    var unusualGearSkill: Ability? {
        _BrandTraitsInfo.shared.traits[self]?.unusualGearSkill
    }
}

internal struct _BrandTraitsInfo: Decodable {
    
    static let shared: _BrandTraitsInfo = {
        let url = SP3Resources.extractedDataDir
            .appendingPathComponent("parameter/misc/spl__BrandTraitsParam.spl__BrandTraitsParam.json", isDirectory: false)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(_BrandTraitsInfo.self, from: data)
    }()
    
    let skillEasilyToGetParam: [Int]
    let traits: [Brand: GearSkillTraits]
    
    enum CodingKeys: String, CodingKey {
        case skillEasilyToGetParam = "SkillEasilyToGetParam"
        case traits = "Traits"
    }
    
    struct GearSkillTraits: Decodable {
        let unusualGearSkill: Ability?
        let usualGearSkill: Ability?
        
        enum CodingKeys: String, CodingKey {
            case usualGearSkill = "UsualGearSkill"
            case unusualGearSkill = "UnusualGearSkill"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let usualGearSkill = try container.decode(String.self, forKey: .usualGearSkill)
            self.usualGearSkill = Ability(usualGearSkill)
            let unusualGearSkill = try container.decode(String.self, forKey: .unusualGearSkill)
            self.unusualGearSkill = Ability(unusualGearSkill)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.skillEasilyToGetParam = try container.decode([Int].self, forKey: .skillEasilyToGetParam)
        let traitsContainer = try container.nestedContainer(keyedBy: Brand.self, forKey: .traits)
        var traits: [Brand: GearSkillTraits] = [:]
        for key in traitsContainer.allKeys {
            traits[key] = try traitsContainer.decode(GearSkillTraits.self, forKey: key)
        }
        self.traits = traits
    }
}
