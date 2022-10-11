//
//  WordPressSimplifyTests_Categories.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests_Categories: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Categories
    func testWPS_CategoryRepository_AllCategories_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch categories")
        var error: Error?

        wps.fetchCategories(filters: [], fields: []) { result in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)

        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_CategoryRepository_AllCategories_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_categories_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch categories")
        var categories = [WPCategory]()

        wps.fetchCategories(filters: [], fields: []) { (result: Result<[WPCategory], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcategories):
                categories = resultcategories
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(categories.count, 4)
        for (idx, category) in categories.enumerated() {
            XCTAssertEqual(category.id, idx + 1)
            XCTAssertEqual(category.count, idx + 1)
            XCTAssertEqual(category.description, "test_\(idx + 1)")
            XCTAssertEqual(category.name, "Test-\(idx + 1)")
            XCTAssertEqual(category.link, "https://test\(idx + 1).com/category/test\(idx + 1)/")
            XCTAssertEqual(category.slug, "test-\(idx + 1)")
            XCTAssertEqual(category.slug, "test-\(idx + 1)")
            XCTAssertEqual(category.taxonomy, "category")
            XCTAssertEqual(category.parent, 0)
        }
    }
    
    func testWPS_CategoryRepository_SpecificCategory_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)

        let exp = expectation(description: "fetch categories")
        var error: Error?

        wps.fetchCategory(id: 1, fields: []) { result in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_CategoryRepository_SpecificCategory_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_category_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch categories")
        
        var category: WPCategory?
        
        wps.fetchCategory(id: 1, fields: []) { (result: Result<WPCategory, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcategory):
                category = resultcategory
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        
        XCTAssertEqual(category?.id, 1)
        XCTAssertEqual(category?.count, 1)
        XCTAssertEqual(category?.description, "test_1")
        XCTAssertEqual(category?.name, "Test-1")
        XCTAssertEqual(category?.link, "https://test1.com/category/test1/")
        XCTAssertEqual(category?.slug, "test-1")
        XCTAssertEqual(category?.slug, "test-1")
        XCTAssertEqual(category?.taxonomy, "category")
        XCTAssertEqual(category?.parent, 0)
    }
    
    func testWPS_CategoryRepository_AllCategories_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)

        let exp = expectation(description: "fetch categories")
        var error: Error?

        wps.fetchCategories(filters: [], fields: []) { (result: Result<[WPCustomCategoryModel], Error>) in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_CategoryRepository_AllCategories_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_categories_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch categories")

        var categories = [WPCustomCategoryModel]()

        wps.fetchCategories(filters: [], fields: []) { (result: Result<[WPCustomCategoryModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcategories):
                categories = resultcategories
            }
            
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0)

        XCTAssertEqual(categories.count, 4)
        for (idx, category) in categories.enumerated() {
            XCTAssertEqual(category.id, idx + 1)
            XCTAssertEqual(category.count, idx + 1)
            XCTAssertEqual(category.description, "test_\(idx + 1)")
            XCTAssertEqual(category.name, "Test-\(idx + 1)")
            XCTAssertEqual(category.link, "https://test\(idx + 1).com/category/test\(idx + 1)/")
            XCTAssertEqual(category.slug, "test-\(idx + 1)")
            XCTAssertEqual(category.slug, "test-\(idx + 1)")
            XCTAssertEqual(category.taxonomy, "category")
            XCTAssertEqual(category.parent, 0)
        }
    }
    
    func testWPS_CategoryRepository_UserCategory_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch category")

        var error: Error?

        wps.fetchCategory(id: 1, fields: []) { (result: Result<WPCustomCategoryModel, Error>) in
            switch result {
            case .failure(let resulterror):
                error = resulterror
            default:
                break
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0)

        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }
    
    func testWPS_CategoryRepository_UserCategory_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_category_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch category")
        var category: WPCustomCategoryModel?
        wps.fetchCategory(id: 1, fields: []) { (result: Result<WPCustomCategoryModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultcategory):
                category = resultcategory
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        
        XCTAssertEqual(category?.id, 1)
        XCTAssertEqual(category?.count, 1)
        XCTAssertEqual(category?.description, "test_1")
        XCTAssertEqual(category?.name, "Test-1")
        XCTAssertEqual(category?.link, "https://test1.com/category/test1/")
        XCTAssertEqual(category?.slug, "test-1")
        XCTAssertEqual(category?.slug, "test-1")
        XCTAssertEqual(category?.taxonomy, "category")
        XCTAssertEqual(category?.parent, 0)
    }
}
