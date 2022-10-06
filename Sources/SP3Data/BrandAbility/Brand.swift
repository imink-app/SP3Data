import Foundation
import seed_checker

public typealias Brand = seed_checker.Brand

extension Brand: SP3Localizable, SP3ImageGetting, CaseIterable {
    
    public var localizedName: String? {
        let key = "CommonMsg/Gear/GearBrandName/" + description
        let value = Bundle.module.localizedString(forKey: key, value: nil, table: "Extracted")
        return value == key ? nil : value
    }
    
    public func imageURL(style: SP3ImageStyle) -> URL? {
        guard style == .default else { return nil }
        return SP3Resources.extractedImageDir
            .appendingPathComponent("brand/\(description).png", isDirectory: false)
            .nilIfUnreachable()
    }
    
    public static let supportedImageStyles: [SP3ImageStyle] = [.default]
    
    public static var allCases: [Brand] = Array(UnsafeBufferPointer(start: all_brands, count: Int(all_brands_count)))
}

extension Brand: LosslessStringConvertible {
    
    public var description: String {
        if rawValue == -1 {
            return "None"
        } else {
            return String(format: "B%02d", rawValue)
        }
    }
    
    public init?(_ description: String) {
        if description == "None" {
            self.init(rawValue: -1)
        } else if description.hasPrefix("B"), let code = Int8(description.dropFirst()) {
            self.init(rawValue: code)
        } else {
            return nil
        }
    }
}

extension Brand: Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let name = try container.decode(String.self)
        guard let brand = Brand(name) else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "illegal Brand code"))
        }
        self = brand
    }
}

extension Brand: CodingKey {
    public var stringValue: String {
        description
    }
    
    public var intValue: Int? {
        nil
    }
    
    public init?(stringValue: String) {
        self.init(stringValue)
    }
    
    public init?(intValue: Int) {
        return nil
    }
}
