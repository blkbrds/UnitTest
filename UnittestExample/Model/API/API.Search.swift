//
//  API.Search.swift
//  UnittestExample
//
//  Created by Su Nguyen T. on 9/18/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper

protocol SearchProtocol {
    static func search(keySearch: String) -> Observable<Result<Categories>>
}

extension Api.Search: SearchProtocol {
    struct SearchParams {
        var key: String = ""

        var JSON: [String: Any] {
            return ["part": "snippet",
                    "key": App.Key.youtubeAPIKey,
                    "maxResults": "25",
                    "q": key]
        }
    }

    static func search(keySearch: String) -> Observable<Result<Categories>> {
        let params = SearchParams(key: keySearch)
        return Observable.create({ observer -> Disposable in
            api.request(method: .get,
                        urlString: Api.Path.Search.path,
                        parameters: params.JSON,
                        completion: { result in
                            switch result {
                            case .success(let data):
                                guard let json = data as? JSObject,
                                    let categories = Mapper<Categories>().map(JSON: json)
                                    else {
                                        observer.onNext(.failure(Api.Error.json))
                                        return
                                }
                                observer.onNext(.success(categories))
                            case .failure(let error):
                                observer.onNext(.failure(error))
                            }
            })
            return Disposables.create()
        })
    }
}
