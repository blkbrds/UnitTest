//
//  Movie.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import Foundation

enum Genre: Int {
    case animation
    case action
    case none
}

final class Movie {
    var title = ""
    var genre: Genre = .none
    var avatar = ""

    func genreString() -> String {
        switch genre {
        case .action:
            return "Action"
        case .animation:
            return "Animation"
        default:
            return "None"
        }
    }

    init() {}

    init(title: String, genre: Genre, avatar: String) {
        self.title = title
        self.genre = genre
        self.avatar = avatar
    }
}

final class MoviesDataHelper {

    static func getMovies() -> [Movie] {
        return [
            Movie(title: "The Emoji Movie", genre: .animation, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "Logan", genre: .action, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "Wonder Woman", genre: .action, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "Zootopia", genre: .animation, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "The Baby Boss", genre: .animation, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "Despicable Me 3", genre: .animation, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "Spiderman: Homecoming", genre: .action, avatar: "https://lorempixel.com/100/100/"),
            Movie(title: "Dunkirk", genre: .animation, avatar: "https://lorempixel.com/100/100/")
        ]
    }
}
