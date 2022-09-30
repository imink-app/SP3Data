import XCTest
@testable import SP3Data

let weapons: [any WeaponInfo] = WeaponInfoMain.allCases + WeaponInfoSub.allCases + WeaponInfoSpecial.allCases

final class WeaponInfoTests: XCTestCase {
    
    func testMain() {
        _testLocalization(weapon: WeaponInfoMain.self)
        _testImage(weapon: WeaponInfoMain.self)
        
        XCTAssertEqual(WeaponInfoMain.allCases.count, 186)
        
        for weapon in WeaponInfoMain.versusWeapons {
            if ![10, 45].contains(weapon.id) {
                // versus weapons without Splattershot Jr. and Hero Shot Replica
                XCTAssert(weapon.shopPrice > 0)
                XCTAssert(weapon.shopUnlockRank > 0)
            }
        }
        
        XCTAssertEqual(WeaponInfoMain.versusWeapons.count, 55)
        XCTAssertEqual(WeaponInfoMain.coopWeapons.count, WeaponInfoMain.versusWeapons.count - 2 - 1 + 5)
        // 2 scope charger, 1 hero weapon is not included. plus 5 grizzco weapons
    }
    
    func testSub() {
        _testLocalization(weapon: WeaponInfoSub.self)
        _testImage(weapon: WeaponInfoSub.self)
        
        XCTAssertEqual(WeaponInfoSub.allCases.count, 31)
        XCTAssertEqual(WeaponInfoSub.versusWeapons.count, 14)
        XCTAssertEqual(WeaponInfoSub.coopWeapons.count, 2)
        // bomb and big bomb(?)
    }
    
    func testSpecial() {
        _testLocalization(weapon: WeaponInfoSpecial.self)
        _testImage(weapon: WeaponInfoSpecial.self)
        
        XCTAssertEqual(WeaponInfoSpecial.allCases.count, 45)
        XCTAssertEqual(WeaponInfoSpecial.versusWeapons.count, 15)
        XCTAssertEqual(WeaponInfoSpecial.coopWeapons.count, 9)
    }
    
    func testAllDamageRate() throws {
        for weapon in weapons {
            XCTAssert(DamageRateInfoRow.allCases.contains(weapon.defaultDamageRateInfoRow))
            for info in weapon.extraDamageRateInfoRowSet {
                XCTAssert(DamageRateInfoRow.allCases.contains(info.damageRateInfoRow))
            }
        }
    }
    
    func testAllHitEffector() throws {
        for weapon in weapons {
            XCTAssert(HitEffectorType.allCases.contains(weapon.defaultHitEffectorType))
            for info in weapon.extraHitEffectorInfoSet {
                XCTAssert(HitEffectorType.allCases.contains(info.hitEffectorType))
            }
        }
    }
    
    func _testLocalization<Weapon: WeaponInfo>(weapon: Weapon.Type) {
        for weapon in Weapon.allCases {
            XCTAssertNotNil(weapon.localizedName)
        }
    }
    
    func _testImage<Weapon: WeaponInfo>(weapon: Weapon.Type) {
        for weapon in Weapon.versusWeapons {
            for style in Weapon.supportedImageStyles {
                XCTAssertNotNil(weapon.imageURL(style: style), "missing image for \(weapon.debugDescription)")
            }
        }
    }
}
