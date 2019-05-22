//
//  OhhttpStubTutorialTests.swift
//  OhhttpStubTutorialTests
//
//  Created by Lam Le V. on 5/21/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import XCTest
import OHHTTPStubs
import Nimble

@testable import OhhttpStubTutorial

final class OhhttpStubTutorialTests: XCTestCase {

    func testSuccessApiResponseWithScheme() {
        #warning("isScheme is error currently, please don't use it")
        let manager = Manager<User>()
        stub(condition: isScheme("https")) { _ in
            let stubPath: String! = OHPathForFile("User.json", type(of: self))
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success(let user):
                    XCTAssertEqual(user.name, "vanlam")
                    XCTAssertEqual(user.age, 29)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                done()
            }
        }
    }

    func testSuccessApiResponseWithHost() {
        let manager = Manager<User>()
        stub(condition: isHost("wwww.google.com.vn")) { _ in
            let stubPath: String! = OHPathForFile("User.json", type(of: self))
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success(let user):
                    XCTAssertEqual(user.name, "vanlam")
                    XCTAssertEqual(user.age, 29)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                done()
            }
        }
    }

    func testSuccessApiResponseWithPath() {
        let manager = Manager<User>()
        stub(condition: isPath("/vanlam")) { _ in
            let stubPath: String! = OHPathForFile("User.json", type(of: self))
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success(let user):
                    XCTAssertEqual(user.name, "vanlam")
                    XCTAssertEqual(user.age, 29)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                done()
            }
        }
    }

    func testSuccessApiResponseWithAbsoluteURLString() {
        let manager = Manager<User>()
        stub(condition: isAbsoluteURLString(Dummy.urlString)) { _ in
            let stubPath: String! = OHPathForFile("User.json", type(of: self))
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success(let user):
                    XCTAssertEqual(user.name, "vanlam")
                    XCTAssertEqual(user.age, 29)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                done()
            }
        }
    }

    func testSuccessApiResponseWithPostMethod() {
        let manager = Manager<User>()
        stub(condition: isMethodPOST()) { _ in
            let stubPath: String! = OHPathForFile("User.json", type(of: self))
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success(let user):
                    XCTAssertEqual(user.name, "vanlam")
                    XCTAssertEqual(user.age, 29)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                done()
            }
        }
    }

    func testFailureApiResponseWithError() {
        let manager = Manager<User>()
        stub(condition: isMethodPOST()) { _ in
            return OHHTTPStubsResponse(error: Dummy.error)
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success:
                    XCTFail("result should be error")
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, "server error")
                }
                done()
            }
        }
    }

    func testFailureApiWithErrorJson() {
        let manager = Manager<User>()
        stub(condition: isMethodPOST()) { _ in
            let stubPath: String! = OHPathForFile("Error.json", type(of: self))
            return fixture(filePath: stubPath, headers: ["Content-Type": "application/json"])
        }
        waitUntil(timeout: Dummy.timeout) { done in
            manager.request(path: Dummy.urlString, method: .post) { result in
                switch result {
                case .success:
                    XCTFail("result should be error")
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, "invalid access token")
                }
                done()
            }
        }
    }
}

extension OhhttpStubTutorialTests {

    struct Dummy {

        static let urlString = "http://wwww.google.com.vn/vanlam"
        static let timeout: TimeInterval = 20
        static let error: NSError = NSError(domain: NSCocoaErrorDomain, code: 500, userInfo: [NSLocalizedDescriptionKey: "server error"])
    }
}
