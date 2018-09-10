//
//  API.Categories.swift
//  UnittestExample
//
//  Created by Quang Phu C. M. on 9/7/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Categories {
    struct CategoryListParams {
        static var JSON: [String: Any] {
            return ["part": "snippet",
                    "key": App.Key.youtubeAPIKey,
                    "regionCode": regionCode]
        }
    }

    @discardableResult
    static func getCategoryList(completion: @escaping Completion) -> Request? {
        let path = Api.Path.Categories.path
        return api.request(method: .get, urlString: path, parameters: CategoryListParams.JSON, completion: { _ in
            DispatchQueue.main.async {
                // TODO: - Pls mapper object and get `channelID` with format example `CategoryList.json`
            }
        })
    }
}
