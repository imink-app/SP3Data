import Foundation

public enum SP3Resources {
    public static let resourcesDir = Bundle.module.resourceURL!
    public static let extractedImageDir = resourcesDir.appendingPathComponent("SP3AssetsPNG", isDirectory: true)
    public static let extractedDataDir = resourcesDir.appendingPathComponent("SP3ExtractedData", isDirectory: true)
}


