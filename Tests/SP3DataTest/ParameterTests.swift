import XCTest
@testable import SP3Data

final class ParameterTests: XCTestCase {
    
    func testWeaponParameters() {
        for weapon in versusWeapons {
            XCTAssertNotNil(weapon.parameterURL, "missing parameter for \(weapon.debugDescription)")
        }
    }
}
