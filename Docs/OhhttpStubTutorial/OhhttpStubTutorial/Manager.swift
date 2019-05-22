//
//  Manager.swift
//  OhhttpStubTutorial
//
//  Created by Lam Le V. on 5/21/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

typealias Completion<Value> = (Result<Value>) -> Void

final class Manager<T: Mappable> {

    func request(path: String, method: HTTPMethod, completion: @escaping Completion<T>) {
        Alamofire.request(path, method: method, parameters: nil).responseJSON { result in
            if let error = result.error {
                completion(.failure(error))
                return
            }
            if let value = result.value as? [String: Any], let apiError = Mapper<ApiError>().map(JSONObject: value["error"]) {
                completion(.failure(apiError.error))
                return
            }
            guard let value = result.value as? [String: Any],
                let user = Mapper<T>().map(JSONObject: value) else {
                completion(.failure(NSError.json))
                return
            }
            completion(.success(user))
        }
    }
}

extension NSError {
    static let json = NSError(domain: NSCocoaErrorDomain, code: 9999, userInfo: [NSLocalizedDescriptionKey: "json error"])
}

extension Error {

    var code: Int {
        let `self` = self as NSError
        return `self`.code
    }
}
