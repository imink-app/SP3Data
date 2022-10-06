import XCTest
@testable import SP3Data

final class GearInfoTests: XCTestCase {
    
    func testCount() {
        XCTAssertEqual(GearInfo.allCases.count, 302)
    }
    
    func testLocalization() {
        for gear in GearInfo.allCases {
            XCTAssertNotNil(gear.localizedName)
        }
    }
    
    func testImage() {
        for gear in GearInfo.allCases where gear.howToGet != .impossible {
            XCTAssertNotNil(gear.imageURL, "Gear \(gear.localizedName ?? gear.label) doesn't have image")
        }
    }
}
