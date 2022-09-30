import XCTest
@testable import SP3Data

final class WeaponInfoSpecialTests: XCTestCase {
    
    func testAllWeapons() throws {
        let weapons = WeaponInfoSpecial.allCases
        XCTAssertEqual(weapons.count, 45)
        
        let versusWeaponsCount = weapons.filter { $0.type == .versus }.count
        XCTAssertEqual(versusWeaponsCount, 16)
        
        let coopWeaponsCount = weapons.filter { $0.type == .coop }.count
        XCTAssertEqual(coopWeaponsCount, 9)
    }
}
