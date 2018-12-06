//
//  CategoriesViewModelTests.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/16/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Mockingjay
import Quick
import Nimble
import Alamofire

@testable import UnittestExample

final class CategoriesViewModelTests: QuickSpec {

    override func spec() {

        var viewModel: CategoriesViewModel!

        context("When init viewModel with call api `categories`") {

            beforeEach {
                viewModel = CategoriesViewModel()
            }

            describe("Test request") {

                it("Get API categories success") {
                    let data = Data(forResource: "CategoryList", ofType: "json", on: self)
                    let path = Api.Path.Categories.path
                    self.stub(http(.get, uri: path), jsonData(data))
                    waitUntil(timeout: DummyTests.timeout) { done in
                        viewModel.getCategories(completion: { (result) in
                            expect(result.isSuccess) == true
                            done()
                        })
                    }
                }

                it("Response should return error which http status code is 400") {
                    let data = Data(forResource: "ErrorDetail", ofType: "json", on: self)
                    let path = Api.Path.Categories.path
                    self.stub(http(.get, uri: path, parameters: Dummy.categoriesParameters), jsonData(data, status: DummyTests.Error.badRequest.code))
                    waitUntil(timeout: DummyTests.timeout) { done in
                        viewModel.getCategories(completion: { (result) in
                            switch result {
                            case .failure(let error):
                                expect(error.code) == DummyTests.Error.badRequest.code
                                expect(error.localizedDescription) == "string."
                            default:
                                fail("result should return error")
                            }
                            done()
                        })
                    }
                }
            }

            describe("Test public func") {

                beforeEach {
                    viewModel = CategoriesViewModel()
                    viewModel.categories = Dummy.categories
                }

                it("Test `viewModelForPlaylist` should return `PlaylistViewModel`") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect { try viewModel.playlistViewModel(at: indexPath) }
                        .to(beAnInstanceOf(PlaylistViewModel.self))
                }

                it("Error should be index is out of bounds") {
                    let indexPath = IndexPath(row: 100, section: 0)
                    expect { try viewModel.playlistViewModel(at: indexPath) }
                        .to(throwError(Errors.indexOutOfBound))
                }

                it("Test `viewModelForItem` should return `CategoriesCellViewModel`") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }.to(beAnInstanceOf(CategoriesCellViewModel.self))
                }

                it("Error should be index is out of bounds") {
                    let indexPath = IndexPath(row: 100, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }
                        .to(throwError(Errors.indexOutOfBound))
                }
            }
        }
    }
}

// MARK: - DUMMY
extension CategoriesViewModelTests {

    struct Dummy {
        static var categoriesParameters: [String: Any] {
            return Api.Categories.CategoryListParams.JSON
        }

        static var categories: Categories {
            let category = Categories()
            category.etag = "\"XI7nbFXulYBIpL0ayR_gDh3eu1k/1v2mrzYSYG6onNLt2qTj13hkQZk\""
            category.kind = "youtube#videoCategoryListResponse"
            category.items = [items]
            return category
        }

        static var items: Items {
            let item = Items()
            item.etag = "\"XI7nbFXulYBIpL0ayR_gDh3eu1k/Xy1mB4_yLrHy_BmKmPBggty2mZQ\""
            item.id = "1"
            item.kind = "youtube#videoCategory"
            item.snippet = snippet
            return item
        }

        static var snippet: Snippet {
            let snippet = Snippet()
            snippet.assignable = true
            snippet.channelId = "UCBR8-60-B28hp2BmDPdntcQ"
            snippet.channelTitle = "Film & Animation"
            return snippet
        }
    }
}
