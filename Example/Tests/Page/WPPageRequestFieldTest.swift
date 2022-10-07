//
//  WPPageRequestFieldTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPPageRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPageRequestField_Without_Fields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [WPRequestField.PageFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }
    
    func testPageRequestField_UsingAllFields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [
            WPRequestField.PageFields.id,
            WPRequestField.PageFields.date,
            WPRequestField.PageFields.dateGmt,
            WPRequestField.PageFields.guid,
            WPRequestField.PageFields.link,
            WPRequestField.PageFields.modified,
            WPRequestField.PageFields.modifiedGmt,
            WPRequestField.PageFields.slug,
            WPRequestField.PageFields.status,
            WPRequestField.PageFields.type,
            WPRequestField.PageFields.parent,
            WPRequestField.PageFields.title,
            WPRequestField.PageFields.content,
            WPRequestField.PageFields.author,
            WPRequestField.PageFields.excerpt,
            WPRequestField.PageFields.featuredMedia,
            WPRequestField.PageFields.commentStatus,
            WPRequestField.PageFields.pingStatus,
            WPRequestField.PageFields.menuOrder,
            WPRequestField.PageFields.template,
            WPRequestField.PageFields.custom(field: "field")
        ]
        
        let queryItems = fields.makeQueryItem()
        
        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,date,date_gmt,guid,link,modified,modified_gmt,slug,status,type,parent,title,content,author,excerpt,featured_media,comment_status,ping_status,menu_order,template,field"
        )
    }

}
