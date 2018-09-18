//
//  ApiCategoriesTest.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Quick
import Nimble
import Mockingjay

@testable import UnittestExample

final class ApiCategoriesTest: QuickSpec {

    override func spec() {
        describe("Test categories api") {

            it("Response should have valid") {
                let data = Data(forResource: "CategoryList", ofType: "json", on: self)
                let path = Api.Path.Categories.path
                self.stub(http(.get, uri: path), jsonData(data))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Categories.getCategoryList(completion: { (result) in
                        switch result {
                        case .success(let categories):
                            if let categories = categories as? Categories {
                                expect(categories.etag) == "\"XI7nbFXulYBIpL0ayR_gDh3eu1k/1v2mrzYSYG6onNLt2qTj13hkQZk\""
                                expect(categories.kind) == "youtube#videoCategoryListResponse"
                            }
                        case .failure(let error):
                            fail(error.localizedDescription)
                        }
                        done()
                    })
                }
            }

            it("Response should return error which http status code is 400") {
                let data = Data(forResource: "ErrorDetail", ofType: "json", on: self)
                let path = Api.Path.Categories.path
                self.stub(http(.get, uri: path, parameters: Dummy.categoriesParameters), jsonData(data, status: DummyTests.Error.badRequest.code))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Categories.getCategoryList(completion: { (result) in
                        expect(result.error?.code) == DummyTests.Error.badRequest.code
                        expect(result.error?.localizedDescription) == "string."
                        done()
                    })
                }
            }

            it("Response should return error which http status code is 401") {
                let data = Data(forResource: "ErrorDetail", ofType: "json", on: self)
                let path = Api.Path.Categories.path
                self.stub(http(.get, uri: path, parameters: Dummy.categoriesParameters), jsonData(data, status: DummyTests.Error.unauthorized.code))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Categories.getCategoryList(completion: { (result) in
                        expect(result.error?.code) == DummyTests.Error.unauthorized.code
                        expect(result.error?.localizedDescription) == "string."
                        done()
                    })
                }
            }

            it("Response should return json error") {
                let body: [[String: Any]] = [["response": "ok"]]
                let path = Api.Path.Categories.path
                self.stub(http(.get, uri: path, parameters: Dummy.categoriesParameters), json(body))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Categories.getCategoryList(completion: { (result) in
                        expect(result.error?.code) == Api.Error.json.code
                        expect(result.error?.localizedDescription) == Api.Error.json.localizedDescription
                        done()
                    })
                }
            }
        }
    }
}

extension ApiCategoriesTest {

    struct Dummy {
        static var categoriesParameters: [String : Any] {
            return Api.Categories.CategoryListParams.JSON
        }
    }
}
