//
//  WordPressSimplifyTests_Users.swift
//  WordPressSimplifyTests
//
//  Created by Diego Badaracco on 20/09/2022.
//

import XCTest
@testable import WordPressSimplify

final class WordPressSimplifyTests_Users: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Users
    func testWPS_UserRepository_AllUsers_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch users")
        
        var error: Error?
        
        wps.fetchUsers(filters: [], fields: []) { result in
            switch result {
            case .failure(let resultError):
                error = resultError
            default:
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }

    func testWPS_UserRepository_AllUsers_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_users_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch users")
        
        var users = [WPUser]()
        
        wps.fetchUsers(filters: [], fields: []) { result in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultusers):
                users = resultusers
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(users.count, 4)
        for (idx, user) in users.enumerated() {
            XCTAssertEqual(user.id, idx + 1)
            XCTAssertEqual(user.name, "test\(idx + 1)")
            XCTAssertEqual(user.url, "http://www.test\(idx + 1).com")
            XCTAssertEqual(user.link, "https://test\(idx + 1).com/author/test\(idx + 1)/")
            XCTAssertEqual(user.slug, "test-\(idx + 1)")
            XCTAssertNotNil(user.avatarUrl(by: .´24´))
            XCTAssertNotNil(user.avatarUrl(by: .´48´))
            XCTAssertNotNil(user.avatarUrl(by: .´96´))
            XCTAssertNotNil(user.avatarUrl(by: .´128´))
        }
    }

    func testWPS_UserRepository_SpecificUser_With_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch user")
        var error: Error?
        
        wps.fetchUser(id: 1, fields: []) { result in
            switch result {
            case .failure(let resultError):
                error = resultError
            default:
                break
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        let castedError = error as? WPNetworkingClientMock.WPNetworkingClientError
        
        XCTAssertTrue(castedError == WPNetworkingClientMock.WPNetworkingClientError.anError)
    }

    func testWPS_UserRepository_SpecificUser_With_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_user_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        let exp = expectation(description: "fetch user")
        
        var user: WPUser!
        
        wps.fetchUser(id: 1, fields: []) { result in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultuser):
                user = resultuser
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "test1")
        XCTAssertEqual(user.url, "http://www.test1.com")
        XCTAssertEqual(user.link, "https://test1.com/author/test1/")
        XCTAssertEqual(user.slug, "test-1")
        XCTAssertNotNil(user.avatarUrl(by: .´24´))
        XCTAssertNotNil(user.avatarUrl(by: .´48´))
        XCTAssertNotNil(user.avatarUrl(by: .´96´))
        XCTAssertNotNil(user.avatarUrl(by: .´128´))
    }

    func testWPS_UserRepository_AllUsers_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch users")
        
        var error: Error?
        
        wps.fetchUsers(filters: [], fields: []) { (result: Result<[WPCustomUserModel], Error>) in
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

    func testWPS_UserRepository_AllUsers_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_users_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch users")
        
        var users = [WPCustomUserModel]()
        
        wps.fetchUsers(filters: [], fields: []) { (result: Result<[WPCustomUserModel], Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultusers):
                users = resultusers
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(users.count, 4)
        for (idx, user) in users.enumerated() {
            XCTAssertEqual(user.id, idx + 1)
            XCTAssertEqual(user.name, "test\(idx + 1)")
            XCTAssertEqual(user.url, "http://www.test\(idx + 1).com")
            XCTAssertEqual(user.link, "https://test\(idx + 1).com/author/test\(idx + 1)/")
            XCTAssertEqual(user.slug, "test-\(idx + 1)")
            XCTAssertNotNil(user.avatarUrl(by: .´24´))
            XCTAssertNotNil(user.avatarUrl(by: .´48´))
            XCTAssertNotNil(user.avatarUrl(by: .´96´))
            XCTAssertNotNil(user.avatarUrl(by: .´128´))
        }
    }

    func testWPS_UserRepository_SpecificUser_WithCustomModel_And_Error() throws {
        let client = WPNetworkingClientMock(localPath: "1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch user")
        
        var error: Error?
        
        wps.fetchUser(id: 1, fields: []) { (result: Result<WPCustomUserModel, Error>) in
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

    func testWPS_UserRepository_SpecificUser_WithCustomModel_And_Success() throws {
        let client = WPNetworkingClientMock(localPath: "fetch_user_1")
        let wps = WordPressSimplify(baseURL: "", networkingClientStrategy: client)
        
        let exp = expectation(description: "fetch user")
        
        var user: WPCustomUserModel!
        
        wps.fetchUser(id: 1, fields: []) { (result: Result<WPCustomUserModel, Error>) in
            switch result {
            case .failure(_ ):
                break
            case .success(let resultuser):
                user = resultuser
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "test1")
        XCTAssertEqual(user.url, "http://www.test1.com")
        XCTAssertEqual(user.link, "https://test1.com/author/test1/")
        XCTAssertEqual(user.slug, "test-1")
        XCTAssertNotNil(user.avatarUrl(by: .´24´))
        XCTAssertNotNil(user.avatarUrl(by: .´48´))
        XCTAssertNotNil(user.avatarUrl(by: .´96´))
        XCTAssertNotNil(user.avatarUrl(by: .´128´))
    }
}
