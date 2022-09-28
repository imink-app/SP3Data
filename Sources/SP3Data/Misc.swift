import Foundation

extension URL {
    
    func nilIfUnreachable() -> URL? {
        return (try? checkResourceIsReachable()) == true ? self : nil
    }
}
