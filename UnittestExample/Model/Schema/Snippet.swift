//
//  Snippet.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import ObjectMapper

final class Snippet: Mappable {

    var channelId: String = ""
    var title: String = ""
    var assignable: Bool = false

    /// Playlist
    var publishedAt: String = ""
    var description: String = ""
    var channelTitle: String = ""
    var thumbnails: Thumbnails = Thumbnails()

    init() {}

    required init?(map: Map) {}

    func mapping(map: Map) {
        channelId <- map["channelId"]
        title <- map["title"]
        assignable <- map["assignable"]
        publishedAt <- map["publishedAt"]
        description <- map["description"]
        channelTitle <- map["channelTitle"]
        thumbnails <- map["thumbnails"]
    }
}
