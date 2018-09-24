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
    private var scheduler: SchedulerType
    private var searchApiProtocol: SearchProtocol.Type
    private var categories = Categories() {
        didSet {
            let viewModels = categories.items.map { (item) -> PlaylistCellViewModel in
                return PlaylistCellViewModel(item: item)
            }
            cellViewModels.onNext(viewModels)
        }
    }

    let disposeBag = DisposeBag()
    let cellViewModels: PublishSubject<[PlaylistCellViewModel]> = PublishSubject<[PlaylistCellViewModel]>()
    let searchCompletion: PublishSubject = PublishSubject<Result<Any>>()

    init(searchApiProtocol: SearchProtocol.Type = Api.Search.self,
         scheduler: SchedulerType = MainScheduler.instance) {
        self.scheduler = scheduler
        self.searchApiProtocol = searchApiProtocol
    }

    func configSearchBar(searchBar: Observable<String>) {
        searchBar.debounce(0.3, scheduler: scheduler)
            .filter({ !$0.isEmpty })
            .flatMapLatest({ (key) -> Observable<Result<Categories>> in
                return self.searchApiProtocol.search(keySearch: key)
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
