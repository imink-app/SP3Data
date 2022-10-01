import XCTest
@testable import SP3Data

let allWeapons: [any WeaponInfo] = WeaponInfoMain.allCases + WeaponInfoSub.allCases + WeaponInfoSpecial.allCases
let versusWeapons: [any WeaponInfo] = WeaponInfoMain.versusWeapons + WeaponInfoSub.versusWeapons + WeaponInfoSpecial.versusWeapons
let coopWeapons: [any WeaponInfo] = WeaponInfoMain.coopWeapons + WeaponInfoSub.coopWeapons + WeaponInfoSpecial.coopWeapons

final class WeaponInfoTests: XCTestCase {
    
    func testMain() {
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
        XCTAssertEqual(WeaponInfoSub.allCases.count, 31)
        XCTAssertEqual(WeaponInfoSub.versusWeapons.count, 14)
        XCTAssertEqual(WeaponInfoSub.coopWeapons.count, 2)
        // bomb and big bomb(?)
    }
    
    func testSpecial() {
        XCTAssertEqual(WeaponInfoSpecial.allCases.count, 45)
        XCTAssertEqual(WeaponInfoSpecial.versusWeapons.count, 15)
        XCTAssertEqual(WeaponInfoSpecial.coopWeapons.count, 9)
    }
    
    func testLocalization() {
        // all weapons should have localized name
        for weapon in allWeapons {
            XCTAssertNotNil(weapon.localizedName)
        }
    }
    
    func testImage() {
        // only versus weapons have image
        for weapon in versusWeapons {
            for style in type(of: weapon).supportedImageStyles {
                XCTAssertNotNil(weapon.imageURL(style: style), "missing image for \(weapon.debugDescription)")
            }
        }
    }
    
    func testAllDamageRate() throws {
        for weapon in allWeapons {
            XCTAssert(DamageRateInfoRow.allCases.contains(weapon.defaultDamageRateInfoRow))
            for info in weapon.extraDamageRateInfoRowSet {
                XCTAssert(DamageRateInfoRow.allCases.contains(info.damageRateInfoRow))
            }
        }
    }
    
    func testAllHitEffector() throws {
        for weapon in allWeapons {
            XCTAssert(HitEffectorType.allCases.contains(weapon.defaultHitEffectorType))
            for info in weapon.extraHitEffectorInfoSet {
                XCTAssert(HitEffectorType.allCases.contains(info.hitEffectorType))
            }
        }
    }
}
