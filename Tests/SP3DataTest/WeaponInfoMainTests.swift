import XCTest
@testable import SP3Data

final class WeaponInfoMainTests: XCTestCase {
    
    func testAllWeapons() throws {
        let weapons = WeaponInfoMain.allCases
        XCTAssertEqual(weapons.count, 186)
        
        for weapon in weapons {
            if weapon.type == .versus, ![10, 45].contains(weapon.id) {
                // versus weapons without Splattershot Jr. and Hero Shot Replica
                XCTAssert(weapon.shopPrice > 0)
                XCTAssert(weapon.shopUnlockRank > 0)
            }
        }
        
        let versusWeaponsCount = weapons.filter { $0.type == .versus }.count
        XCTAssertEqual(versusWeaponsCount, 55)
        
        let coopWeaponsCount = weapons.filter { $0.type == .coop }.count
        XCTAssertEqual(coopWeaponsCount, versusWeaponsCount - 2 - 1 + 5)
        // 2 scope charger, 1 hero weapon is not included. plus 5 grizzco weapons
    }
    
    func testLocalization() {
        let jr = WeaponInfoMain.allCases.first { $0.id == 10 }
        XCTAssertEqual(jr?.localizedName, "新叶射击枪")
    }
    
    func testImage() {
        let versusWeapons = WeaponInfoMain.allCases.filter { $0.type == .versus }
        for weapon in versusWeapons {
            for style in WeaponInfoMain.ImageStyle.allCases {
                XCTAssertNotNil(weapon.imageURL(style: style))
            }
        }
    }
}
