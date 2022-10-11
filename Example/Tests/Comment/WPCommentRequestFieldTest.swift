//
//  WPCommentRequestFieldTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPCommentRequestFieldTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCommentRequestField_Without_Fields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [WPRequestField.CommentFields]()
        XCTAssertTrue(fields.valueQueryItem.isEmpty)
        XCTAssertNil(fields.makeQueryItem())
    }
    
    func testCommentRequestField_UsingAllFields() throws {
        let fields: [WPRequestFieldTypeProtocol] = [
            WPRequestField.CommentFields.id,
            WPRequestField.CommentFields.author,
            WPRequestField.CommentFields.authorEmail,
            WPRequestField.CommentFields.authorName,
            WPRequestField.CommentFields.authorUrl,
            WPRequestField.CommentFields.date,
            WPRequestField.CommentFields.dateGmt,
            WPRequestField.CommentFields.content,
            WPRequestField.CommentFields.link,
            WPRequestField.CommentFields.parent,
            WPRequestField.CommentFields.post,
            WPRequestField.CommentFields.status,
            WPRequestField.CommentFields.type,
            WPRequestField.CommentFields.authorAvatarUrls,
            WPRequestField.CommentFields.custom(field: "field")
        ]
        
        let queryItems = fields.makeQueryItem()
        
        XCTAssertTrue(!fields.valueQueryItem.isEmpty)
        XCTAssertEqual(queryItems!.name, "_fields")
        XCTAssertEqual(queryItems!.value, fields.valueQueryItem)
        XCTAssertEqual(
            queryItems!.value,
            "id,author,author_email,author_name,author_url,date,date_gmt,content,link,parent,post,status,type,author_avatar_urls,field"
        )
    }
}
