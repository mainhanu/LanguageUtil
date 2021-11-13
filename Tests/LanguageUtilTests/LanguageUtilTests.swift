import XCTest
import Nimble

@testable import LanguageUtil

let langutil = LanguageUtil.shared;

final class LanguageUtilTests: XCTestCase {
    func testIcon() throws {
        expect(langutil.icon(forLang: "swift")).to(equal("file_type_swift"))
    }

    func testColor() throws {
        expect(langutil.color(forLang: "swift")).to(equal("#F05138"))
    }
}
