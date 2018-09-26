//
//  SearchViewController.swift
//  UnittestExample
//
//  Created by Su Nguyen T. on 9/18/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchViewController: ViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    private let disposeBag = DisposeBag()

    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        configSearchBar()
        viewModel.configSearchBar(searchBar: searchBar.rx.text.orEmpty.asObservable())
        configTableView()
        handleResult()
    }

    // MARK: Private func
    private func configTableView() {
        tableView.register(PlaylistCell.self)
        tableView.rowHeight = 112

        viewModel.cellViewModels.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: "PlaylistCell",
                       cellType: PlaylistCell.self)) { _, cellViewModel, cell in
                        cell.viewModel = cellViewModel
            }.disposed(by: disposeBag)
    }

    private func handleResult() {
        viewModel.searchCompletion
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let this = self else { return }
                if case .failure(let error) = result {
                    this.alert(error: error)
                }
            })
            .disposed(by: disposeBag)
    }

    private func configSearchBar() {
        // Handle show/hide `cancel` button of searchBar
        searchBar.rx.text.orEmpty.asObservable()
            .map({ $0.isEmpty })
            .subscribe(onNext: { [weak self] isEmpty in
                self?.searchBar.showsCancelButton = !isEmpty
            })
            .disposed(by: disposeBag)

        // Handle `cancel` button is tapped
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
}
