//
//  WPPageRequestFiltersTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPPageRequestFiltersTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListPageFilters() throws {
        let filters: [WPRequestFilter.ListPage] = [
            .context(type: .view),
            .page(number: 1),
            .perPage(number: 1),
            .search(value: "pepe"),
            .after(dateISO8601: "1"),
            .author(id: 1),
            .authorExclude(ids: [1,2]),
            .before(dateISO8601: "1"),
            .exclude(ids: [1,2]),
            .include(ids: [1,2]),
            .offset(number: 1),
            .order(type: .asc),
            .orderBy(type: .id),
            .slug(slugs: ["test"]),
            .status(value: .publish),
            .menuOrder(value: 1),
            .parent(ids: [1,2]),
            .parentExclude(ids: [1,2])

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
        XCTAssertEqual(queryItems[4].value, "1")
        
        XCTAssertEqual(queryItems[5].name, "author")
        XCTAssertEqual(queryItems[5].value, "1")
        
        XCTAssertEqual(queryItems[6].name, "author_exclude")
        XCTAssertEqual(queryItems[6].value, "1,2")
        
        XCTAssertEqual(queryItems[7].name, "before")
        XCTAssertEqual(queryItems[7].value, "1")
        
        XCTAssertEqual(queryItems[8].name, "exclude")
        XCTAssertEqual(queryItems[8].value, "1,2")
        
        XCTAssertEqual(queryItems[9].name, "include")
        XCTAssertEqual(queryItems[9].value, "1,2")
        
        XCTAssertEqual(queryItems[10].name, "offset")
        XCTAssertEqual(queryItems[10].value, "1")
        
        XCTAssertEqual(queryItems[11].name, "order")
        XCTAssertEqual(queryItems[11].value, "asc")
        
        XCTAssertEqual(queryItems[12].name, "orderby")
        XCTAssertEqual(queryItems[12].value, "id")
        
        XCTAssertEqual(queryItems[13].name, "slug")
        XCTAssertEqual(queryItems[13].value, "test")
        
        XCTAssertEqual(queryItems[14].name, "status")
        XCTAssertEqual(queryItems[14].value, "publish")
        
        XCTAssertEqual(queryItems[15].name, "menu_order")
        XCTAssertEqual(queryItems[15].value, "1")
        
        XCTAssertEqual(queryItems[16].name, "parent")
        XCTAssertEqual(queryItems[16].value, "1,2")
        
        XCTAssertEqual(queryItems[17].name, "parent_exclude")
        XCTAssertEqual(queryItems[17].value, "1,2")
        
    }
    
    func testListPageFilters_With_EmptyList() throws {
        let filters = [WPRequestFilter.ListPage.search(value: "")]
        let queryItems = (filters as [WPRequestFilterProtocol]).makeQueryItems()
        XCTAssertTrue(queryItems.isEmpty)
    }

}
