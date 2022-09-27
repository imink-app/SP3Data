import Foundation

let resourcesUrl = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("SP3Data/Resources")

func parseStringFile() throws {
    let srcDir = resourcesUrl.appendingPathComponent("SP3ExtractedData/language")
    let dstDir = resourcesUrl.appendingPathComponent("Localization")

    let lanMap = [
        "CNzh": "zh-Hans",
        "TWzh": "zh-Hant",
        "EUde": "de",
        "EUen": "en",
        "EUes": "es",
        "EUfr": "fr",
        "EUit": "it",
        "EUnl": "nl",
        "EUru": "ru",
        "JPja": "ja",
        "KRko": "ko",
    ]

    for (srcCode, dstCode) in lanMap {
        let srcUrl = srcDir.appendingPathComponent(srcCode).appendingPathExtension("json")
        let l10nDir = dstDir.appendingPathComponent("\(dstCode).lproj", isDirectory: true)
        let dstUrl = l10nDir.appendingPathComponent("Extracted").appendingPathExtension("strings")

        let data = try Data(contentsOf: srcUrl)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: [String: String]]
        var result = ""
        for (path, item) in json.sorted(by: { $0.key < $1.key }) {
            for (key, string) in item.sorted(by: { $0.key < $1.key }) {
                // TODO: parse something like [color=ffff] and [group=0004 type=0007 params=00 00 00 00]
                let str = string.replacingOccurrences(of: "\n", with: "\\n")
                    .replacingOccurrences(of: #"""#, with: #"\""#)
                result += "\"\(path)/\(key)\" = \"\(str)\";\n"
            }
        }
        try FileManager().createDirectory(at: l10nDir, withIntermediateDirectories: true)
        try result.write(to: dstUrl, atomically: true, encoding: .utf8)
    }
}
