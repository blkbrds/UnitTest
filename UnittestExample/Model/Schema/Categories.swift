//
//  Categories.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import ObjectMapper

final class Categories: Mappable {

    var kind: String = ""
    var etag: String = ""
    var items: [Items] = []

    ///Playlist
    var nextPageToken: String = ""
    var pageInfo: PageInfo = PageInfo()

    init() {}

    required init?(map: Map) {}

    func mapping(map: Map) {
        kind <- map["kind"]
        etag <- map["etag"]
        items <- map["items"]
        nextPageToken <- map["nextPageToken"]
        pageInfo <- map["pageInfo"]
    }
}
