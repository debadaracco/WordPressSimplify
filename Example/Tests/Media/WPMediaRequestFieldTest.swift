//
//  WPMediaRequestFieldTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 09/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPMediaRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMediaRequestField_Without_Fields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [WPRequestField.MediaFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }
    
    func testMediaRequestField_UsingAllFields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [
            WPRequestField.MediaFields.id,
            WPRequestField.MediaFields.date,
            WPRequestField.MediaFields.dateGmt,
            WPRequestField.MediaFields.guid,
            WPRequestField.MediaFields.link,
            WPRequestField.MediaFields.modified,
            WPRequestField.MediaFields.modifiedGmt,
            WPRequestField.MediaFields.slug,
            WPRequestField.MediaFields.status,
            WPRequestField.MediaFields.type,
            WPRequestField.MediaFields.title,
            WPRequestField.MediaFields.author,
            WPRequestField.MediaFields.commentStatus,
            WPRequestField.MediaFields.pingStatus,
            WPRequestField.MediaFields.template,
            WPRequestField.MediaFields.altText,
            WPRequestField.MediaFields.caption,
            WPRequestField.MediaFields.description,
            WPRequestField.MediaFields.mediaType,
            WPRequestField.MediaFields.mimeType,
            WPRequestField.MediaFields.mediaDetails,
            WPRequestField.MediaFields.post,
            WPRequestField.MediaFields.sourceUrl,
            WPRequestField.MediaFields.custom(field: "field")
        ]
        
        let queryItems = fields.makeQueryItem()
        
        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,date,date_gmt,guid,link,modified,modified_gmt,slug,status,type,title,author,comment_status,ping_status,template,alt_text,caption,description,media_type,mime_type,media_details,post,source_url,field"
        )
    }
}
