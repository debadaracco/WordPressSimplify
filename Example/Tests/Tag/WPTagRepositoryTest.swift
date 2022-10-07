//
//  WPTagRepositoryTest.swift
//  WordPressSimplify_Tests
//
//  Created by Diego Badaracco on 07/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import WordPressSimplify

final class WPTagRepositoryTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testTagRepository_AllTags_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPTagRepository(networking: networking)
        repository.fetch(filters: [], fields: []) { (result: Result<[WPTag], Error>) in
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
    
    func testTagRepository_AllTags_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tags_1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPTagRepository(networking: networking)
        repository.fetch(filters: [], fields: []) { (result: Result<[WPTag], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let tags):
                XCTAssertTrue(tags.count == 4)
                for (idx, tag) in tags.enumerated() {
                    XCTAssertEqual(tag.id, idx + 1)
                    XCTAssertEqual(tag.count, idx + 1)
                    XCTAssertEqual(tag.description, "test_\(idx + 1)")
                    XCTAssertEqual(tag.link, "https://test\(idx + 1).com/tag/test\(idx + 1)/")
                    XCTAssertEqual(tag.name, "Test-\(idx + 1)")
                    XCTAssertEqual(tag.slug, "test-\(idx + 1)")
                    XCTAssertEqual(tag.taxonomy, "tag")
                }
            }
        }
    }
    
    func testTagRepository_SpecificTag_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPTagRepository(networking: networking)
        repository.fetch(id: 1, fields: []) { (result: Result<WPTag, Error>) in
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
    
    func testTagRepository_SpecificTag_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_tag_1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPTagRepository(networking: networking)
        repository.fetch(id: 1, fields: []) { (result: Result<WPTag, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let tag):
                XCTAssertEqual(tag.id, 1)
                XCTAssertEqual(tag.count, 1)
                XCTAssertEqual(tag.description, "test_1")
                XCTAssertEqual(tag.link, "https://test1.com/tag/test1/")
                XCTAssertEqual(tag.name, "Test-1")
                XCTAssertEqual(tag.slug, "test-1")
                XCTAssertEqual(tag.taxonomy, "tag")
            }
        }
    }

}
