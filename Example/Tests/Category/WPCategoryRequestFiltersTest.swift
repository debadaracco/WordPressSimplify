//
//  WPCategoryRequestFiltersTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 05/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPCategoryRequestFiltersTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListCategoryFilters() throws {
        let filters: [WPRequestFilter.ListCategory] = [
            .context(type: .view),
            .page(number: 1),
            .perPage(number: 1),
            .search(value: "pepe"),
            .exclude(ids: [1,2]),
            .include(ids: [1,3]),
            .hideEmpty,
            .parent(value: 1),
            .post(value: 2),
            .order(type: .asc),
            .orderBy(type: .id),
            .slug(slugs: ["slug1"]),
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
        XCTAssertEqual(queryItems[4].name, "exclude")
        XCTAssertEqual(queryItems[4].value, "1,2")
        XCTAssertEqual(queryItems[5].name, "include")
        XCTAssertEqual(queryItems[5].value, "1,3")
        XCTAssertEqual(queryItems[6].name, "hide_empty")
        XCTAssertEqual(queryItems[6].value, "1")
        XCTAssertEqual(queryItems[7].name, "parent")
        XCTAssertEqual(queryItems[7].value, "1")
        XCTAssertEqual(queryItems[8].name, "post")
        XCTAssertEqual(queryItems[8].value, "2")
        XCTAssertEqual(queryItems[9].name, "order")
        XCTAssertEqual(queryItems[9].value, "asc")
        XCTAssertEqual(queryItems[10].name, "orderby")
        XCTAssertEqual(queryItems[10].value, "id")
        XCTAssertEqual(queryItems[11].name, "slug")
        XCTAssertEqual(queryItems[11].value, "slug1")
        XCTAssertEqual(queryItems[12].name, "key")
        XCTAssertEqual(queryItems[12].value, "value")
    }
    
    func testListCategoryFilters_With_EmptyList() throws {
        let filters = [WPRequestFilter.ListCategory.search(value: "")]
        let queryItems = (filters as [WPRequestFilterProtocol]).makeQueryItems()
        XCTAssertTrue(queryItems.isEmpty)
    }
}
