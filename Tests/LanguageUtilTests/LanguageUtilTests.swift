import XCTest
import Nimble

@testable import LanguageUtil

let langutil = LanguageUtil.shared;

final class LanguageUtilTests: XCTestCase {
    func testColor() throws {
        expect(langutil.color(forLang: "swift")).to(equal("#F05138"))
    }
}
