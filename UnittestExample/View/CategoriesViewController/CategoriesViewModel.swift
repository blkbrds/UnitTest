//
//  CategoriesViewModel.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import MVVM
import SwiftUtils

final class CategoriesViewModel: ViewModel {

    private(set) var categories: Categories?

    var items: [Items] {
        guard let items = categories?.items else { return [] }
        return items
    }

    /// Number of item for user display in table view
    ///
    /// - Parameter section: section of table view
    /// - Returns: number of items display in table view
    func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }

    /// Make view model for CategoriesCellViewModel
    ///
    /// - Parameter indexPath: indexPath of each item in tableView
    /// - Returns: CategoriesCellViewModel at indexPath parameter
    func viewModelForItem(at indexPath: IndexPath) -> CategoriesCellViewModel {
        guard let item = categories?.items[indexPath.row] else {
            return CategoriesCellViewModel()
        }
        let viewModel = CategoriesCellViewModel(item: item)
        return viewModel
    }

    /// Make view model for PlaylistViewModel
    ///
    /// - Parameter indexPath: indexPath of each item in tableView
    /// - Returns: PlaylistViewModel at indexPath parameter
    /// - Throws: If indexPath.row >=  items.count throws index out of bound error
    func playlistViewModel(at indexPath: IndexPath) throws -> PlaylistViewModel {
        guard indexPath.row < items.count else {
            throw Errors.indexOutOfBound
        }
        let chanelId = items[indexPath.row].snippet.channelId
        let viewModel = PlaylistViewModel(chanelID: chanelId)
        return viewModel
    }
}

extension CategoriesViewModel {

    /// Call api of categories
    ///
    /// - Parameter completion: completion
    func getCategories(completion: @escaping Completion) {
        Api.Categories.getCategoryList { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let categories):
                this.categories = categories as? Categories
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
