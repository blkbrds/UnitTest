//
//  SearchViewModel.swift
//  UnittestExample
//
//  Created by Su Nguyen T. on 9/18/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import MVVM
import RxSwift
import Alamofire

final class SearchViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    private var items: [Items] = []
    private var categories = Categories() {
        didSet {
            items = categories.items
        }
    }

    let searchCompletion: PublishSubject = PublishSubject<Result<Any>>()

    init() { }

    func configSearchBar(searchBar: Observable<String>) {
        searchBar.debounce(0.3, scheduler: MainScheduler.instance)
            .filter({ !$0.isEmpty })
            .flatMapLatest({ (key) -> Observable<Result<Categories>> in
                return Api.Search.search(keySearch: key)
            })
            .subscribe(onNext: { [weak self] result in
                guard let this = self else { return }
                switch result {
                case .success(let categories):
                    this.categories = categories
                    this.searchCompletion.onNext(.success(true))
                case .failure(let error):
                    this.searchCompletion.onNext(.failure(error))
                }
            })
        .disposed(by: disposeBag)
    }
}

extension SearchViewModel {
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
    func viewModelForItem(at indexPath: IndexPath) throws -> PlaylistCellViewModel {
        guard indexPath.row < items.count else {
            throw Errors.indexOutOfBound
        }
        let item = items[indexPath.row]
        let viewModel = PlaylistCellViewModel(item: item)
        return viewModel
    }
}
