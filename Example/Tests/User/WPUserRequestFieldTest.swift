//
//  WPUserRequestFieldTest.swift
//  WordPressSimplifyTests-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import XCTest
@testable import WordPressSimplify

final class WPUserRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserRequestField_Without_Fields() throws {
        let fields = [WPRequestField.UserFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }

    func testUserRequestField_UsingAllFields() throws {
        let fields: [WPRequestField.UserFields] = [
            .id,
            .username,
            .name,
            .firstName,
            .lastName,
            .email,
            .url,
            .description,
            .link,
            .locale,
            .nickname,
            .slug
        ]

        let queryItems = fields.makeQueryItem()

        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,username,name,first_name,last_name,email,url,description,link,locale,nickname,slug"
        )
    }
}
