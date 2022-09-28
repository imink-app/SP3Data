import XCTest
@testable import SP3Data

final class WeaponInfoSubTests: XCTestCase {
    
    func testAllWeapons() throws {
        let weapons = WeaponInfoSub.allCases
        XCTAssertEqual(weapons.count, 31)
        
        let versusWeaponsCount = weapons.filter { $0.type == .versus }.count
        XCTAssertEqual(versusWeaponsCount, 14)
        
        let coopWeaponsCount = weapons.filter { $0.type == .coop }.count
        XCTAssertEqual(coopWeaponsCount, 2)
        // bomb and big bomb(?)
    }
    
    func testLocalization() {
        let sp = WeaponInfoSub.allCases.first { $0.id == 3 }
        XCTAssertEqual(sp?.localizedName, "洒墨器")
    }
    
    func testImage() {
        let versusWeapons = WeaponInfoSub.allCases.filter { $0.type == .versus }
        for weapon in versusWeapons {
            for style in WeaponInfoSub.ImageStyle.allCases {
                XCTAssertNotNil(weapon.imageURL(style: style))
            }
        }
    }
}
