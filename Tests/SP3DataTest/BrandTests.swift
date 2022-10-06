import XCTest
@testable import SP3Data

final class BrandTests: XCTestCase {
    
    func testCount() {
        let allBrands = _BrandTraitsInfo.shared.traits.keys
            .filter { $0.rawValue != -1 && $0.rawValue != 18 }
            .sorted { $0.rawValue < $1.rawValue }
        XCTAssertEqual(Brand.allCases, allBrands)
    }
    
    func testLocalization() {
        for brand in Brand.allCases {
            XCTAssertNotNil(brand.localizedName)
        }
    }
    
    func testImage() {
        for brand in Brand.allCases {
            XCTAssertNotNil(brand.imageURL)
        }
    }
}
