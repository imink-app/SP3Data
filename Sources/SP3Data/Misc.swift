import Foundation

extension URL {
    
    func nilIfUnreachable() -> URL? {
        if (try? checkResourceIsReachable()) == true {
            return self
        } else {
            return nil
        }
    }
}
