//
//  Items.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import ObjectMapper

final class Items: Mappable {

    var kind: String = ""
    var etag: String = ""
    var id: String = ""
    var snippet: Snippet = Snippet()

    init() {}

    required init?(map: Map) { }

    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        id <- map["id"]
        snippet <- map["snippet"]
    }
}
