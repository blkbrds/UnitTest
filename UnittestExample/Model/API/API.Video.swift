//
//  API.Video.swift
//  UnittestExample
//
//  Created by Quang Phu C. M. on 9/7/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Video {
    struct VideoListParams {
        let playlistID: String

        var JSON: [String: Any] {
            return ["part": "snippet",
                    "key": App.Key.youtubeAPIKey,
                    "playlistId": playlistID]
        }
    }

    @discardableResult
    static func getVideoList(param: VideoListParams, completion: @escaping Completion) -> Request? {
        let path = Api.Path.Video.path
        return api.request(method: .get, urlString: path, parameters: param.JSON, completion: { _ in
            DispatchQueue.main.async {
                // TODO: - Pls mapper video object with format example `Video.json`
            }
        })
    }
}
