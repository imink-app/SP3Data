import Foundation

private let resourcesUrl = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("SP3Data/Resources")

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
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
                result += "\"\(path)/\(key)\" = \"\(processLocalizedString(string))\";\n"
            }
        }
        try FileManager().createDirectory(at: l10nDir, withIntermediateDirectories: true)
        try result.write(to: dstUrl, atomically: true, encoding: .utf8)
    }
}

import RegexBuilder

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
private func processLocalizedString(_ str: String) -> String {
    let colorfulText = Regex {
        One("[color=0001]")
        Capture {
            ZeroOrMore(.any, .reluctant)
        }
        One("[color=ffff]")
    }
    let fadingText = Regex {
        One("[color=0000]")
        Capture {
            ZeroOrMore(.any, .reluctant)
        }
        One("[color=ffff]")
    }
    let custom = Regex {
        "[group="
        Capture {
            OneOrMore(.any)
        }
        " type="
        Capture {
            OneOrMore(.any)
        }
        " params="
        Capture {
            ZeroOrMore(.any)
        }
        "]"
    }
    
    // TODO: parse something like [group=0004 type=0007 params=00 00 00 00]
    return str
        .replacingOccurrences(of: "\n", with: #"\n"#)
        .replacingOccurrences(of: "[page break]", with: "↡")
        .replacingOccurrences(of: #"""#, with: #"\""#)
        .replacing(colorfulText) { $0.1.isEmpty ? "" : "**\($0.1)**" } // bold
        .replacing(fadingText) { $0.1.isEmpty ? "" : "_\($0.1)_" } // italic
        .replacing(custom) { _ in "�" }
}
