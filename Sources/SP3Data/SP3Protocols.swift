import Foundation

public protocol SP3RowID {
    var __rowId: String { get }
}

public protocol SP3Localizable {
    /// Splatoon 3 official localized name
    var localizedName: String? { get }
}

public protocol SP3ImageGetting {
    /// Splatoon 3 extracted image
    func imageURL(style: SP3ImageStyle) -> URL?
    static var supportedImageStyles: [SP3ImageStyle] { get }
}

extension SP3ImageGetting {
    public func imageURL() -> URL? { imageURL(style: .default) }
}

public enum SP3ImageStyle {
    case `default`
    case flat
    
    case badge00
    case badge01
    case badge02
    case badge03
    
    case sticker00
    /// shining sticker
    case sticker01
}
