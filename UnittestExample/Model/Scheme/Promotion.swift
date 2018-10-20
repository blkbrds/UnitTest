//
//  Promotion.swift
//  MyApp
//
//  Created by Hai Nguyen H.P. on 2/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Promotion: Mappable {
    var id = 0
    var thumbImage = ""
    var long = 0.0
    var lat = 0.0
    var address = ""
    var title = ""
    var code = ""
    var categoryId = 0

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["aaaa"]
        thumbImage <- map["aaaa"]
        long <- map["aaaa"]
        lat <- map["aaaa"]
        address <- map["aaaa"]
        title <- map["aaaa"]
        code <- map["aaaa"]
        categoryId <- map["aaaa"]
    }
}
