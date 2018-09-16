//
//  PlaylistViewModel.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import Foundation
import MVVM

final class PlaylistViewModel: ViewModel {

    private var chanelID: String
    private(set) var categories: Categories?

    /// Init with parameter is chanel id
    ///
    /// - Parameter chanelID: id of chanel, use for call api playlist
    init(chanelID: String = "") {
        self.chanelID = chanelID
    }

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

    /// Make view model for PlaylistCellViewModel
    ///
    /// - Parameter indexPath: indexPath of each item in tableView
    /// - Returns: PlaylistCellViewModel at indexPath parameter
    func viewModelForItem(at indexPath: IndexPath) -> PlaylistCellViewModel {
        guard let item = categories?.items[indexPath.row] else {
            return PlaylistCellViewModel()
        }
        let viewModel = PlaylistCellViewModel(item: item)
        return viewModel
    }
}

extension PlaylistViewModel {

    /// Call api of playlist
    ///
    /// - Parameter completion: completion
    func getPlaylist(completion: @escaping Completion) {
        let param = Api.Playlist.PlaylistParams(channelID: chanelID)
        Api.Playlist.getPlaylist(param: param, completion: { [weak self] result  in
            guard let this = self else { return }
            switch result {
            case .success(let categories):
                this.categories = categories as? Categories
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
