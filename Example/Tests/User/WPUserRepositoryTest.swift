//
//  WPUserRepositoryTest.swift
//  WordPressSimplifyTests-iOS
//
//  Created by Diego Badaracco on 23/09/2022.
//

import XCTest
@testable import WordPressSimplify

final class WPUserRepositoryTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserRepository_AllUsers_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPUserRepository(networking: networking)
        repository.fetch(filters: [], fields: []) { (result: Result<[WPUser], Error>) in
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

    func testUserRepository_AllUsers_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_users_1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPUserRepository(networking: networking)
        repository.fetch(filters: [], fields: []) { (result: Result<[WPUser], Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let users):
                XCTAssertTrue(users.count == 4)
                for (idx, user) in users.enumerated() {
                    XCTAssertEqual(user.id, idx + 1)
                    XCTAssertEqual(user.name, "test\(idx + 1)")
                    XCTAssertEqual(user.url, "http://www.test\(idx + 1).com")
                    XCTAssertEqual(user.link, "https://test\(idx + 1).com/author/test\(idx + 1)/")
                    XCTAssertEqual(user.slug, "test-\(idx + 1)")
                }
            }
        }
    }

    func testUserRepository_SpecificUser_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPUserRepository(networking: networking)
        repository.fetch(id: 1, fields: []) { (result: Result<WPUser, Error>) in
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

    func testUserRepository_SpecificUser_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_user_1")
        let networking = WPNetworking(baseURL: "", clientStrategy: client)
        let repository = WPUserRepository(networking: networking)
        repository.fetch(id: 1, fields: []) { (result: Result<WPUser, Error>) in
            switch result {
            case .failure(_ ):
                XCTAssertTrue(false)
            case .success(let user):
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.name, "test1")
                XCTAssertEqual(user.url, "http://www.test1.com")
                XCTAssertEqual(user.link, "https://test1.com/author/test1/")
                XCTAssertEqual(user.slug, "test-1")
            }
        }
    }
}
