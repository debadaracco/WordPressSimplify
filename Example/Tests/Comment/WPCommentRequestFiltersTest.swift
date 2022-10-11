//
//  WPCommentRequestFiltersTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPCommentRequestFiltersTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListCommentFilters() throws {
        let filters: [WPRequestFilter.ListComment] = [
            .context(type: .view),
            .page(number: 1),
            .perPage(number: 1),
            .search(value: "pepe"),
            .after(dateISO8601: "after"),
            .before(dateISO8601: "before"),
            .exclude(ids: [1,2]),
            .include(ids: [1,3]),
            .offset(number: 1),
            .order(type: .asc),
            .orderBy(type: .id),
            .parent(id: 1),
            .parentExclude(ids: [1,2]),
            .post(id: 1),
            .status(value: .approved),
            .custom(key: "key", value: "value")
        ]
        let queryItems = (filters as [WPRequestFilterProtocol]).makeQueryItems()
        XCTAssertEqual(queryItems[0].name, "context")
        XCTAssertEqual(queryItems[0].value, "view")
        XCTAssertEqual(queryItems[1].name, "page")
        XCTAssertEqual(queryItems[1].value, "1")
        XCTAssertEqual(queryItems[2].name, "per_page")
        XCTAssertEqual(queryItems[2].value, "1")
        XCTAssertEqual(queryItems[3].name, "search")
        XCTAssertEqual(queryItems[3].value, "pepe")
        XCTAssertEqual(queryItems[4].name, "after")
        XCTAssertEqual(queryItems[4].value, "after")
        XCTAssertEqual(queryItems[5].name, "before")
        XCTAssertEqual(queryItems[5].value, "before")
        XCTAssertEqual(queryItems[6].name, "exclude")
        XCTAssertEqual(queryItems[6].value, "1,2")
        XCTAssertEqual(queryItems[7].name, "include")
        XCTAssertEqual(queryItems[7].value, "1,3")
        XCTAssertEqual(queryItems[8].name, "offset")
        XCTAssertEqual(queryItems[8].value, "1")
        XCTAssertEqual(queryItems[9].name, "order")
        XCTAssertEqual(queryItems[9].value, "asc")
        XCTAssertEqual(queryItems[10].name, "orderby")
        XCTAssertEqual(queryItems[10].value, "id")
        XCTAssertEqual(queryItems[11].name, "parent")
        XCTAssertEqual(queryItems[11].value, "1")
        XCTAssertEqual(queryItems[12].name, "parent_exclude")
        XCTAssertEqual(queryItems[12].value, "1,2")
        XCTAssertEqual(queryItems[13].name, "post")
        XCTAssertEqual(queryItems[13].value, "1")
        XCTAssertEqual(queryItems[14].name, "status")
        XCTAssertEqual(queryItems[14].value, "approved")
        XCTAssertEqual(queryItems[15].name, "key")
        XCTAssertEqual(queryItems[15].value, "value")
    }
    
    func testListCommentFilters_With_EmptyList() throws {
        let filters = [WPRequestFilter.ListComment.search(value: "")]
        let queryItems = (filters as [WPRequestFilterProtocol]).makeQueryItems()
        XCTAssertTrue(queryItems.isEmpty)
    }
}
