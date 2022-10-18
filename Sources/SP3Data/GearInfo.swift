import Foundation

extension GearInfo: SP3Localizable, SP3ImageGetting, CaseIterable {
    
    public enum GearType: CaseIterable {
        case head
        case clothes
        case shoes
    }
    
    public var type: GearType {
        switch __rowId.prefix(3) {
        case "Hed": return .head
        case "Clt": return .clothes
        case "Shs": return .shoes
        default: fatalError("unknown GearInfo.__rowId")
        }
    }
    
    public var localizedName: String? {
        let keyPath: String
        switch type {
        case .head:     keyPath = "CommonMsg/Gear/GearName_Head/"
        case .clothes:  keyPath = "CommonMsg/Gear/GearName_Clothes/"
        case .shoes:    keyPath = "CommonMsg/Gear/GearName_Shoes/"
        }
        let key = keyPath + __rowId.dropFirst(4)
        let value = Bundle.module.localizedString(forKey: key, value: nil, table: "Extracted")
        return value == key ? nil : value
    }
    
    public func imageURL(style: SP3ImageStyle) -> URL? {
        guard style == .default else { return nil }
        return SP3Resources.extractedImageDir
            .appendingPathComponent("gear/\(__rowId).png", isDirectory: false)
            .nilIfUnreachable()
    }
    
    public static let supportedImageStyles: [SP3ImageStyle] = [.default]
    
    public static let allHead: [GearInfo] = {
        let url = SP3Resources.extractedDataDir.appendingPathComponent("mush/GearInfoHead.json", isDirectory: false)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode([GearInfo].self, from: data)
    }()
    
    public static let allClothes: [GearInfo] = {
        let url = SP3Resources.extractedDataDir.appendingPathComponent("mush/GearInfoClothes.json", isDirectory: false)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode([GearInfo].self, from: data)
    }()
    
    public static let allShoes: [GearInfo] = {
        let url = SP3Resources.extractedDataDir.appendingPathComponent("mush/GearInfoShoes.json", isDirectory: false)
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode([GearInfo].self, from: data)
    }()
    
    public static let allCases: [GearInfo] = allHead + allClothes + allShoes
}

// MARK: - ResultElement
public struct GearInfo: Codable, Hashable {
    public let __rowId: String
    public let brand: Brand
    public let howToGet: HowToGet
    public let id: Int
    public let label: String
    public let price: Int
    public let rarity: Int
    public let season: Int
    public let skill: Ability
    
    public let alphaMaskF: String
    public let alphaMaskM: String
    public let captureModelType: String
    public let genre0: String
    public let genre1: String
    public let harnessType: String
    public let headParamSetPath: String
    public let isHideHarness: Bool
    public let isThinHarness: Bool
    public let isUnisex: Bool
    public let lObjParam: String
    public let lObjParamM: String
    public let material: String
    public let urokoPrice: UrokoPrice
    public let urokoUnlockLevel: Int
    public let variationNum: Int

    enum CodingKeys: String, CodingKey {
        case alphaMaskF = "AlphaMaskF"
        case alphaMaskM = "AlphaMaskM"
        case brand = "Brand"
        case captureModelType = "CaptureModelType"
        case genre0 = "Genre0"
        case genre1 = "Genre1"
        case harnessType = "HarnessType"
        case headParamSetPath = "HeadParamSetPath"
        case howToGet = "HowToGet"
        case id = "Id"
        case isHideHarness = "IsHideHarness"
        case isThinHarness = "IsThinHarness"
        case isUnisex = "IsUnisex"
        case lObjParam = "LObjParam"
        case lObjParamM = "LObjParamM"
        case label = "Label"
        case material = "Material"
        case price = "Price"
        case rarity = "Rarity"
        case season = "Season"
        case skill = "Skill"
        case urokoPrice = "UrokoPrice"
        case urokoUnlockLevel = "UrokoUnlockLevel"
        case variationNum = "VariationNum"
        case __rowId = "__RowId"
    }
}

extension GearInfo {
    
    public enum HowToGet: String, Codable, Hashable {
        case catalog = "Catalog"
        case impossible = "Impossible"
        case other = "Other"
        case shop = "Shop"
    }
    
    public struct UrokoPrice: Codable, Hashable {
        
        public let goldUrokoNum: Int
        public let silverUrokoNum: Int
        public let bronzeUrokoNum: Int
        
        enum CodingKeys: String, CodingKey {
            case goldUrokoNum = "GoldUrokoNum"
            case silverUrokoNum = "SilverUrokoNum"
            case bronzeUrokoNum = "BronzeUrokoNum"
        }
    }
}
