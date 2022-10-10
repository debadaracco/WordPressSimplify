//
//  WPCategoryRequestFieldTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 05/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPCategoryRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCategoryRequestField_Without_Fields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [WPRequestField.CategoryFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }
    
    func testCategoryRequestField_UsingAllFields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [
            WPRequestField.CategoryFields.id,
            WPRequestField.CategoryFields.count,
            WPRequestField.CategoryFields.description,
            WPRequestField.CategoryFields.link,
            WPRequestField.CategoryFields.name,
            WPRequestField.CategoryFields.slug,
            WPRequestField.CategoryFields.taxonomy,
            WPRequestField.CategoryFields.parent,
            WPRequestField.CategoryFields.custom(field: "field")
        ]
        
        let queryItems = fields.makeQueryItem()
        
        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,count,description,link,name,slug,taxonomy,parent,field"
        )
    }
}
