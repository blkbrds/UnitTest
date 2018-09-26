//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

let regionCode = "VN"

final class Api {
    struct Path {
        static let baseURL = "https://www.googleapis.com/youtube" / v3
        static let v3 = "v3"
    }

    struct Categories { }

    struct Playlist { }

    struct Video { }

    struct Search { }
}

extension Api.Path {

    /// Get list categories
    struct Categories {
        static var path: String { return Api.Path.baseURL / "videoCategories" }
    }

    /// Get playlist from idChanel
    struct Playlist {
        static var path: String { return Api.Path.baseURL / "playlists" }
    }

    /// Get list video from playlistID
    struct Video {
        static var path: String { return Api.Path.baseURL / "playlistItems" }
    }

    struct Search {
        static var path: String { return Api.Path.baseURL / "search" }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
