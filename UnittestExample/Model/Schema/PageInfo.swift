//
//  PageInfo.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import ObjectMapper

final class PageInfo: Mappable {

    var totalResults: Int = 0
    var resultsPerPage: Int = 0

    init() {}

    required init?(map: Map) {}

    func mapping(map: Map) {
        totalResults <- map["totalResults"]
        resultsPerPage <- map["resultsPerPage"]
    }
}
