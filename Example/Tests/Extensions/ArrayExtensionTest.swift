//
//  ArrayExtensionTest.swift
//  WordPressSimplifyTests-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import XCTest
@testable import WordPressSimplify

final class ArrayExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMakeQueryItemValue_WithComma_UsingString() throws {
        let content = ["1", "2"]
        let result = content.makeQueryItemValue()
        XCTAssertEqual(result, "1,2")
    }

    func testMakeQueryItemValue_WithoutComma_UsingString() throws {
        let content = ["1"]
        let result = content.makeQueryItemValue()
        XCTAssertEqual(result, "1")
    }

    func testMakeQueryItemValue_WithComma_UsingInt() throws {
        let content = [1, 2]
        let result = content.makeQueryItemValue()
        XCTAssertEqual(result, "1,2")
    }

    func testMakeQueryItemValue_WithoutComma_UsingInt() throws {
        let content = [1]
        let result = content.makeQueryItemValue()
        XCTAssertEqual(result, "1")
    }
}
