//
//  WordPressSimplifyTests_Tags.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 10/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify
final class WordPressSimplifyTests_Tags: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tags
    func testWPS_TagRepository_AllTags_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch tags")
        
        var error: Error?
        wps.fetchTags(filters: [], fields: []) { result in
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
    
    func testWPS_TagRepository_AllTags_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tags_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch tags")
        
        var tags = [WPTag]()
        wps.fetchTags(filters: [], fields: []) { (result: Result<[WPTag], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resulttags):
                tags = resulttags
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(tags.count, 4)
        for (idx, tag) in tags.enumerated() {
            XCTAssertEqual(tag.id, idx + 1)
            XCTAssertEqual(tag.count, idx + 1)
            XCTAssertEqual(tag.description, "test_\(idx + 1)")
            XCTAssertEqual(tag.name, "Test-\(idx + 1)")
            XCTAssertEqual(tag.link, "https://test\(idx + 1).com/tag/test\(idx + 1)/")
            XCTAssertEqual(tag.slug, "test-\(idx + 1)")
            XCTAssertEqual(tag.slug, "test-\(idx + 1)")
            XCTAssertEqual(tag.taxonomy, "tag")
        }
    }
    
    func testWPS_TagRepository_SpecificTag_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch tag")
        
        var error: Error?
        
        wps.fetchTag(id: 1, fields: []) { result in
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
    
    func testWPS_TagRepository_SpecificTag_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tag_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch tag")
        
        var tag: WPTag!
        
        wps.fetchTag(id: 1, fields: []) { (result: Result<WPTag, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resulttag):
                tag = resulttag
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        
        XCTAssertEqual(tag.id, 1)
        XCTAssertEqual(tag.count, 1)
        XCTAssertEqual(tag.description, "test_1")
        XCTAssertEqual(tag.name, "Test-1")
        XCTAssertEqual(tag.link, "https://test1.com/tag/test1/")
        XCTAssertEqual(tag.slug, "test-1")
        XCTAssertEqual(tag.slug, "test-1")
        XCTAssertEqual(tag.taxonomy, "tag")
    }
    
    func testWPS_TagRepository_AllTags_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch tags")
        
        var error: Error?
        
        wps.fetchTags(filters: [], fields: []) { (result: Result<[WPCustomTagModel], Error>) in
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
    
    func testWPS_TagRepository_AllTags_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tags_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch tags")
        
        var tags = [WPCustomTagModel]()
        wps.fetchTags(filters: [], fields: []) { (result: Result<[WPCustomTagModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resulttags):
                tags = resulttags
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(tags.count, 4)
        for (idx, tag) in tags.enumerated() {
            XCTAssertEqual(tag.id, idx + 1)
            XCTAssertEqual(tag.count, idx + 1)
            XCTAssertEqual(tag.description, "test_\(idx + 1)")
            XCTAssertEqual(tag.name, "Test-\(idx + 1)")
            XCTAssertEqual(tag.link, "https://test\(idx + 1).com/tag/test\(idx + 1)/")
            XCTAssertEqual(tag.slug, "test-\(idx + 1)")
            XCTAssertEqual(tag.slug, "test-\(idx + 1)")
            XCTAssertEqual(tag.taxonomy, "tag")
        }
    }
    
    func testWPS_TagRepository_UserTag_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch tag")
        
        var error: Error?
        wps.fetchTag(id: 1, fields: []) { (result: Result<WPCustomTagModel, Error>) in
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
    
    func testWPS_TagRepository_UserTag_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tag_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch tag")
        var tag: WPCustomTagModel!
        wps.fetchTag(id: 1, fields: []) { (result: Result<WPCustomTagModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let restag):
                tag = restag
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        
        XCTAssertEqual(tag.id, 1)
        XCTAssertEqual(tag.count, 1)
        XCTAssertEqual(tag.description, "test_1")
        XCTAssertEqual(tag.name, "Test-1")
        XCTAssertEqual(tag.link, "https://test1.com/tag/test1/")
        XCTAssertEqual(tag.slug, "test-1")
        XCTAssertEqual(tag.slug, "test-1")
        XCTAssertEqual(tag.taxonomy, "tag")
    }
}
