//
//  WPTagRequestFieldTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPTagRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTagRequestField_Without_Fields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [WPRequestField.TagFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }
    
    func testTagRequestField_UsingAllFields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [
            WPRequestField.TagFields.id,
            WPRequestField.TagFields.count,
            WPRequestField.TagFields.description,
            WPRequestField.TagFields.link,
            WPRequestField.TagFields.name,
            WPRequestField.TagFields.slug,
            WPRequestField.TagFields.taxonomy,
            WPRequestField.TagFields.custom(field: "field")
        ]
        
        let queryItems = fields.makeQueryItem()
        
        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,count,description,link,name,slug,taxonomy,field"
        )
    }
}
