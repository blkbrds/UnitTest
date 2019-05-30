//
//  ApiError.swift
//  OhhttpStubTutorial
//
//  Created by Lam Le V. on 5/22/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import ObjectMapper

final class ApiError: Mappable {

    var code: Int = 0
    var message = ""

    init?(map: Map) {}

    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }

    var error: NSError {
        return NSError(domain: NSCocoaErrorDomain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
