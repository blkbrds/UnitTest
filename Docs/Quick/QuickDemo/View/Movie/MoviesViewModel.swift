//
//  MoviesViewModel.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import Foundation
import MVVM

final class MoviesViewModel: ViewModel {

    var movies: [Movie] = MoviesDataHelper.getMovies()

    func numberOfItems(inSection section: Int) -> Int {
        return movies.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> MoviesCellViewModel {
        let index = indexPath.row
        guard index < movies.count else {
            throw Errors.indexOutOfBound
        }
        return MoviesCellViewModel(movie: movies[indexPath.row])
    }
}
