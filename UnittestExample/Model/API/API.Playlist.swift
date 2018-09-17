//
//  API.Playlist.swift
//  UnittestExample
//
//  Created by Quang Phu C. M. on 9/7/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Playlist {
    struct PlaylistParams {
        let channelID: String

        var JSON: [String: Any] {
            return ["part": "snippet",
                    "key": App.Key.youtubeAPIKey,
                    "channelId": channelID]
        }
    }

    @discardableResult
    static func getPlaylist(param: PlaylistParams, completion: @escaping Completion) -> Request? {
        let path = Api.Path.Playlist.path
        return api.request(method: .get, urlString: path, parameters: param.JSON, completion: { result in
            DispatchQueue.main.async {
                // TODO: - Pls mapper object and get `playlistID` = Items[0].id with format example `Playlist.json`
                switch result {
                case .success(let value):
                    guard let json = value as? JSObject,
                        let categories = Mapper<Categories>().map(JSON: json) else {
                            completion(.failure(Api.Error.json))
                            return
                    }
                    completion(.success(categories))
                case .failure(let error): completion(.failure(error))
                }
            }
        })
    }
}
