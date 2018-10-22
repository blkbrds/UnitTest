//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        static let baseURL = "https://api.foursquare.com/v2"

    }

    struct Venues {
        let id: String

        init(id: String) {
            self.id = id
        }
    }

    struct WebView { }
}
// MARK: - WebView
extension Api.WebView {

    struct Google {

        private static let path = "https://foursquare.com/oauth2"

        static let authenticate: String = path / "authenticate"
    }
}

extension Api.Path {

    struct Venues {
        private static let path = baseURL / "venues"
        private let id: String
        static let trending = path / "trending"

        init(id: String) {
            self.id = id
        }

        var detail: String {
            return Venues.path / id
        }
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
