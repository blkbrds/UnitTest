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
            guard let value = result.value as? [String: Any],
                let user = Mapper<T>().map(JSONObject: value) else {
                return
            }
            completion(.success(user))
        }
    }
}
