//
//  ApiPlaylistTests.swift
//  UnittestExampleTests
//
//  Created by ToanTV on 9/17/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Quick
import Nimble
import Mockingjay

@testable import UnittestExample

final class ApiPlaylistTests: QuickSpec {

    override func spec() {
        describe("Test categories api") {

            it("Response should have valid") {
                let data = Data(forResource: "Playlist", ofType: "json", on: self)
                let path = Api.Path.Playlist.path
                self.stub(http(.get, uri: path, parameters: Dummy.playlistParameters), jsonData(data))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Playlist.getPlaylist(param: Api.Playlist.PlaylistParams(channelID: Dummy.channelID), completion: { (result) in
                        switch result {
                        case .success(let playlist):
                        if let playlist = playlist as? Categories {
                            expect(playlist.etag) == "\"XI7nbFXulYBIpL0ayR_gDh3eu1k/lvTbhK89DaXa1C59ZiGuVAgUBAk\""
                            expect(playlist.kind) == "youtube#playlistListResponse"
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
                let path = Api.Path.Playlist.path
                self.stub(http(.get, uri: path, parameters: Dummy.playlistParameters), jsonData(data, status: DummyTests.Error.badRequest.code))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Playlist.getPlaylist(param: Api.Playlist.PlaylistParams(channelID: Dummy.channelID), completion: { (result) in
                        expect(result.error?.code) == DummyTests.Error.badRequest.code
                        expect(result.error?.localizedDescription) == "string."
                        done()
                    })
                }
            }

            it("Response should return error which http status code is 401") {
                let data = Data(forResource: "ErrorDetail", ofType: "json", on: self)
                let path = Api.Path.Playlist.path
                self.stub(http(.get, uri: path, parameters: Dummy.playlistParameters), jsonData(data, status: DummyTests.Error.unauthorized.code))
                waitUntil(timeout: DummyTests.timeout) { done in
                     Api.Playlist.getPlaylist(param: Api.Playlist.PlaylistParams(channelID: Dummy.channelID), completion: { (result) in
                        expect(result.error?.code) == DummyTests.Error.unauthorized.code
                        expect(result.error?.localizedDescription) == "string."
                        done()
                    })
                }
            }

            it("Response should return json error") {
                let body: [[String: Any]] = [["response": "ok"]]
                let path = Api.Path.Playlist.path
                self.stub(http(.get, uri: path, parameters: Dummy.playlistParameters), json(body))
                waitUntil(timeout: DummyTests.timeout) { done in
                    Api.Playlist.getPlaylist(param: Api.Playlist.PlaylistParams(channelID: Dummy.channelID), completion: { (result) in
                        expect(result.error?.code) == Api.Error.json.code
                        expect(result.error?.localizedDescription) == Api.Error.json.localizedDescription
                        done()
                    })
                }
            }
        }
    }
}

extension ApiPlaylistTests {

    struct Dummy {
        static var channelID = "UCBR8-60-B28hp2BmDPdntcQ"
        static var playlistParameters: [String: Any] {
            return Api.Playlist.PlaylistParams(channelID: channelID).JSON
        }
    }
}
