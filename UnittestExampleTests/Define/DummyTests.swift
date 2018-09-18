//
//  DummyTests.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import UIKit
import SwiftUtils

@testable import UnittestExample
struct DummyTests {

    static let timeout: TimeInterval = 20
}

extension DummyTests {

    struct Error {

        static let badRequest: NSError = NSError(domain: Api.Path.baseURL.host, code: 400, message: "The request cannot be fulfilled due to bad syntax.")

        static let unauthorized: NSError = NSError(domain: Api.Path.baseURL.host, code: 401, message: "The request was a legal request, but the server is refusing to respond to it. For use when authentication is possible but has failed or not yet been provided.")

        static let forbidden: NSError = NSError(domain: Api.Path.baseURL.host, code: 403, message: "The request was a legal request, but the server is refusing to respond to it.")

        static let notFound: NSError = NSError(domain: Api.Path.baseURL.host, code: 404, message: "The requested page could not be found but may be available again in the future.")

        static let preconditionFailed: NSError = NSError(domain: Api.Path.baseURL.host, code: 412, message: "The precondition given in the request evaluated to false by the server.")

        static let unsupportedMediaType: NSError = NSError(domain: Api.Path.baseURL.host, code: 415, message: "The server will not accept the request, because the media type is not supported.")

        static let internalServerError: NSError = NSError(domain: Api.Path.baseURL.host, code: 500, message: "A generic error message, given when no more specific message is suitable.")

        static let cancelRequest: NSError = NSError(domain: Api.Path.baseURL.host, code: 999, message: "Server returns no information and closes the connection.")

        static let invalidURL: NSError = NSError(domain: Api.Path.baseURL.host, code: 998, message: "Cannot detect URL")

        static let upgradeRequire: NSError = NSError(domain: Api.Path.baseURL.host, code: 426, message: "Force Update")

        static let invalid: NSError = NSError(domain: Api.Path.baseURL.host, code: 9999, message: "Parameter has no value")
    }
}
