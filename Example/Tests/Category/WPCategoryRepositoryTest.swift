//
//  WPCategoryRepositoryTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 05/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPCategoryRepositoryTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCategoryRepository_AllCategories_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPCategoryRepository(networking: networking)
        repository.fetch(filters: [], fields: []) { (result: Result<[WPCategory], Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(
                    castedError == WPNetworkingClientMock.WPNetworkingClientError.anError
                )
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testCategoryRepository_AllCategories_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_categories_1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPCategoryRepository(networking: networking)
        repository.fetch(filters: [], fields: []) { (result: Result<[WPCategory], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let categories):
                XCTAssertTrue(categories.count == 4)
                for (idx, category) in categories.enumerated() {
                    XCTAssertEqual(category.id, idx + 1)
                    XCTAssertEqual(category.count, idx + 1)
                    XCTAssertEqual(category.description, "test_\(idx + 1)")
                    XCTAssertEqual(category.link, "https://test\(idx + 1).com/category/test\(idx + 1)/")
                    XCTAssertEqual(category.name, "Test-\(idx + 1)")
                    XCTAssertEqual(category.slug, "test-\(idx + 1)")
                    XCTAssertEqual(category.taxonomy, "category")
                    XCTAssertEqual(category.parent, 0)
                }
            }
        }
    }
    
    func testCategoryRepository_SpecificCategory_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPCategoryRepository(networking: networking)
        repository.fetch(id: 1, fields: []) { (result: Result<WPCategory, Error>) in
            switch result {
            case .failure(let error):
                let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
                XCTAssertTrue(
                    castedError == WPNetworkingClientMock.WPNetworkingClientError.anError
                )
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    func testCategoryRepository_SpecificCategory_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_category_1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPCategoryRepository(networking: networking)
        repository.fetch(id: 1, fields: []) { (result: Result<WPCategory, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let category):
                XCTAssertEqual(category.id, 1)
                XCTAssertEqual(category.count, 1)
                XCTAssertEqual(category.description, "test_1")
                XCTAssertEqual(category.link, "https://test1.com/category/test1/")
                XCTAssertEqual(category.name, "Test-1")
                XCTAssertEqual(category.slug, "test-1")
                XCTAssertEqual(category.taxonomy, "category")
                XCTAssertEqual(category.parent, 0)
            }
        }
    }
}
