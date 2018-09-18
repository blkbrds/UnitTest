//
//  PlaylistViewModelTests.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Mockingjay
import Quick
import Nimble
import Alamofire

@testable import UnittestExample

final class PlaylistViewModelTests: QuickSpec {

    override func spec() {
        var viewModel: PlaylistViewModel!

        context("When init viewModel with call api `playlist`") {

            beforeEach {
                viewModel = PlaylistViewModel(chanelID: Dummy.channelID)
            }

            describe("Test request") {

                it("Get API playlist success") {
                    let data = Data(forResource: "Playlist", ofType: "json", on: self)
                    let path = Api.Path.Playlist.path
                    self.stub(http(.get, uri: path, parameters: Dummy.playlistParameters), jsonData(data))
                    waitUntil(timeout: DummyTests.timeout) { done in
                        viewModel.getPlaylist(completion: { (result) in
                            expect(result.isSuccess) == true
                            done()
                        })
                    }
                }

                it("Response should return error which http status code is 400") {
                    let data = Data(forResource: "ErrorDetail", ofType: "json", on: self)
                    let path = Api.Path.Playlist.path
                    self.stub(http(.get, uri: path, parameters: Dummy.playlistParameters), jsonData(data, status: DummyTests.Error.badRequest.code))
                    waitUntil(timeout: DummyTests.timeout) { done in
                        viewModel.getPlaylist(completion: { (result) in
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

                it("Number of items should return 0") {
                    expect(viewModel.numberOfItems(inSection: 0)) == 0
                }
            }

            describe("Test public func") {

                beforeEach {
                    viewModel = PlaylistViewModel()
                    viewModel.categories = Dummy.categories
                }

                it("Test `viewModelForItem` should return `PlaylistCellViewModel`") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }.to(beAnInstanceOf(PlaylistCellViewModel.self))
                }

                it("Error should be index is out of bounds") {
                    let indexPath = IndexPath(row: 100, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }
                        .to(throwError(Errors.indexOutOfBound))
                }

                it("Number of items should return 1") {
                    expect(viewModel.numberOfItems(inSection: 0)) == 1
                }
            }
        }
    }
}

// MARK: - DUMMY
extension PlaylistViewModelTests {

    struct Dummy {
        static var channelID = "UCBR8-60-B28hp2BmDPdntcQ"
        static var playlistParameters: [String: Any] {
            return Api.Playlist.PlaylistParams(channelID: channelID).JSON
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
