//
//  MoviesCellViewModel.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import Foundation
import MVVM

final class MoviesCellViewModel: ViewModel {
    var title = ""
    var image = ""
    var description = ""

    init(movie: Movie = Movie()) {
        title = movie.title
        image = movie.avatar
        description = movie.genreString()
    }
}
