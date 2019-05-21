//
//  User.swift
//  OhhttpStubTutorial
//
//  Created by Lam Le V. on 5/21/19.
//  Copyright © 2019 Lam Le V. All rights reserved.
//

import ObjectMapper

final class User: Mappable {

    var name: String?
    var age: Int?

    init?(map: Map) {
    }

    func mapping(map: Map) {
        name <- map["name"]
        age <- map["age"]
    }
}
