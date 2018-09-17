//
//  API.Categories.swift
//  UnittestExample
//
//  Created by Quang Phu C. M. on 9/7/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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
        return api.request(method: .get, urlString: path, parameters: CategoryListParams.JSON, completion: { result in
            DispatchQueue.main.async {
                // TODO: - Pls mapper object and get `channelID` with format example `CategoryList.json`
                switch result {
                case .success(let value):
                    guard let json = value as? JSObject,
                        let categories = Mapper<Categories>().map(JSON: json) else {
                            completion(.failure(Api.Error.json))
                            return
                    }
                    completion(.success(categories))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        })
    }
}
