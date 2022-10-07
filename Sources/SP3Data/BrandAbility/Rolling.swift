import Foundation
import seed_checker

public typealias AbilityRollingSeed = seed_checker.AbilityRollingSeed
public typealias SingleRoll = seed_checker.SingleRoll

extension AbilityRollingSeed: Codable, Comparable, ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt32) {
        self.init(rawValue: value)
    }
    
    public static func < (lhs: AbilityRollingSeed, rhs: AbilityRollingSeed) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public mutating func nextAbility(brand: Brand, drink: Ability? = nil) -> Ability {
        return get_ability(self, brand, drink ?? .none).ability
    }
    
    public static func search(brand: Brand, history: [SingleRoll], start: AbilityRollingSeed = .init(1), limit: Int, reportingProgress: (Double) -> Void) -> [AbilityRollingSeed] {
        class Context {
            let closure: (Double) -> Void
            init(closure: @escaping (Double) -> Void) { self.closure = closure }
            static let c_closure: @convention(c) (Double, UnsafeRawPointer?) -> Void = { progress, contextPtr in
                contextPtr.map(Unmanaged<Context>.fromOpaque)?.takeUnretainedValue().closure(progress)
            }
        }
        return Array(unsafeUninitializedCapacity: limit) { resultPtr, initializedCount in
            var resultCount = limit
            withoutActuallyEscaping(reportingProgress) { escapingClosure in
                withExtendedLifetime(Context(closure: escapingClosure)) { ctx in
                    let ctxPtr = Unmanaged.passUnretained(ctx).toOpaque()
                    history.withUnsafeBufferPointer { historyPtr in
                        search_seed(brand, historyPtr.baseAddress, historyPtr.count, start, resultPtr.baseAddress, &resultCount, Context.c_closure, ctxPtr)
                    }
                }
            }
            initializedCount = resultCount
        }
    }
}
