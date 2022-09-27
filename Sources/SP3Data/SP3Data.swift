import Foundation

let resourcesDir = Bundle.module.resourceURL!
let extractedImageDir = resourcesDir.appendingPathComponent("SP3AssetsPNG", isDirectory: true)
let extractedDataDir = resourcesDir.appendingPathComponent("SP3ExtractedData", isDirectory: true)
