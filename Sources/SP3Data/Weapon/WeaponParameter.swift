import Foundation

public extension WeaponInfo {
    
    var parameterURL: URL? {
        var name = specActor
        guard name.hasPrefix("Work/Actor/"),
              name.hasSuffix(".engine__actor__ActorParam.gyml") else {
            assertionFailure("unknown SpecActor")
            return nil
        }
        name.removeFirst(11)
        name.removeLast(31)
        return SP3Resources.extractedDataDir
            .appendingPathComponent("parameter/weapon/\(name).game__GameParameterTable.json", isDirectory: false)
            .nilIfUnreachable()
    }
}
