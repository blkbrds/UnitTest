//
//  Categories.swift
//  UnittestExampleTests
//
//  Created by MBA0219 on 9/25/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Quick
import Nimble
import Alamofire
import Mockingjay

@testable import UnittestExample

class ApiCategoriesTests: QuickSpec {

    override func spec() {
        describe("Test Api Categories") {
            it("When Call Api Categories success") {
                let data = Data(forResource: "CategoryList", ofType: "json", on: self)
                let path = Api.Path.Categories.path
                self.stub(http(.get, uri: path, parameters: Api.Categories.CategoryListParams.JSON), jsonData(data))
                waitUntil(timeout: 20, action: { done in
                    Api.Categories.getCategoryList(completion: { (result) in
                        switch result {
                        case .success(let value):
                            if let value = value as? Categories {
                                expect(value.kind) == "youtube#videoCategoryListResponse"
                                expect(value.etag) == "\"XI7nbFXulYBIpL0ayR_gDh3eu1k/1v2mrzYSYG6onNLt2qTj13hkQZk\""
                            } else {
                                fail("respone")
                           }
                        case .failure(let error):
                            fail(error.localizedDescription)
                        }
                        done()
                    })
                })
            }
        }
    }
}
