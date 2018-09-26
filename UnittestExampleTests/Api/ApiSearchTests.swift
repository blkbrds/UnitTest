//
//  ApiSearchTests.swift
//  UnittestExampleTests
//
//  Created by Su Nguyen T. on 9/24/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxTest
import RxSwift
import RxBlocking
import Mockingjay

@testable import UnittestExample

final class ApiSearchTests: QuickSpec {
    override func spec() {
        describe("Test Api.Search") {
            it("Should failure") {
                self.stub(http(.get, uri: Api.Path.Search.path), failure(Api.Error.json))
                let observable = Api.Search.search(keySearch: "youtube")
                let result = observable.toBlocking().firstOrNil()
                expect(result?.isSuccess) == false
                expect(result?.error?.code) == Api.Error.json.code
                expect(result?.error?.localizedDescription) == Api.Error.json.localizedDescription
            }
        }
    }
}
