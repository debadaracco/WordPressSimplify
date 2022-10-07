//
//  WPPostRequestFieldTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPPostRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPostRequestField_Without_Fields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [WPRequestField.PostFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }
    
    func testPostRequestField_UsingAllFields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [
            WPRequestField.PostFields.id,
            WPRequestField.PostFields.date,
            WPRequestField.PostFields.dateGmt,
            WPRequestField.PostFields.guid,
            WPRequestField.PostFields.link,
            WPRequestField.PostFields.modified,
            WPRequestField.PostFields.modifiedGmt,
            WPRequestField.PostFields.slug,
            WPRequestField.PostFields.status,
            WPRequestField.PostFields.type,
            WPRequestField.PostFields.title,
            WPRequestField.PostFields.content,
            WPRequestField.PostFields.author,
            WPRequestField.PostFields.excerpt,
            WPRequestField.PostFields.featuredMedia,
            WPRequestField.PostFields.commentStatus,
            WPRequestField.PostFields.pingStatus,
            WPRequestField.PostFields.format,
            WPRequestField.PostFields.sticky,
            WPRequestField.PostFields.template,
            WPRequestField.PostFields.categories,
            WPRequestField.PostFields.tags
        ]
        
        let queryItems = fields.makeQueryItem()
        
        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,date,date_gmt,guid,link,modified,modified_gmt,slug,status,type,title,content,author,excerpt,featured_media,comment_status,ping_status,format,sticky,template,categories,tags"
        )
    }
}
