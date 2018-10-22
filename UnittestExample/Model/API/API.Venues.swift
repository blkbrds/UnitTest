//
//  API.GetTrendingVenues.swift
//  UnittestExample
//
//  Created by MBA0237P on 10/22/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import RxSwift
import Alamofire
import ObjectMapper

protocol VenuesRepository {
    func getTrending(parameter: Api.Venues.Parameter) -> Observable<Result<[Venue]>>
    func getDetail(id: String) -> Observable<Result<Venue>>
}

extension Api.Venues: VenuesRepository {
    struct Parameter {
        let id: String?
        let limit: Int = 10
        let radius: Int = 1000

        var toJSON: [String: Any] {
            var params: [String: Any] = [:]
            params["limit"] = limit
            params["radius"] = radius
            params["client_id"] = App.Foursquare.clienID
            params["client_secret"] = App.Foursquare.clienSecret
            return params
        }
    }

    func getTrending(parameter: Api.Venues.Parameter) -> Observable<Result<[Venue]>> {
        let path = Api.Path.Venues.trending
        return Observable<Result<[Venue]>>.create { observe -> Disposable in
                api.rxRequest(method: .get, urlString: path, parameters: parameter.toJSON)
                .subscribe(onNext: { result in
                    switch result {
                    case .success(let value):
                        guard let json = value as? JSObject,
                            let venueArray = json[""] as? JSArray else {
                                observe.onNext(.failure(Api.Error.json))
                                return
                        }
                        let venues = Mapper<Venue>().mapArray(JSONArray: venueArray)
                        observe.onNext(.success(venues))
                    case .failure(let error):
                        observe.onNext(.failure(error))
                    }
            })
        }
    }

    func getDetail(id: String) -> Observable<Result<Venue>> {
        let path = Api.Path.Venues(id: id).detail
        return Observable<Result<Venue>>.create { observe -> Disposable in
            api.rxRequest(method: .get, urlString: path).subscribe(onNext: { result in
                switch result {
                case .success(let value):
                    guard let json = value as? JSObject,
                        let response = json["response"] as? JSObject,
                        let venueJSON = response["venue"] as? JSObject,
                        let venue = Mapper<Venue>().map(JSON: venueJSON) else {
                            observe.onNext(.failure(Api.Error.json))
                            return
                    }
                    observe.onNext(.success(venue))
                case .failure(let error):
                    observe.onNext(.failure(error))
                }
            })
        }
    }
}
