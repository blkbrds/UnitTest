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
        configTableView()
        viewModel.configSearchBar(searchBar: searchBar.rx.text.orEmpty.asObservable())
        handleResult()
    }

    // MARK: Private func
    private func configTableView() {
        tableView.register(PlaylistCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func handleResult() {
        viewModel.searchCompletion
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let this = self else { return }
                switch result {
                case .success:
                    this.tableView.reloadData()
                    if this.tableView.numberOfRows(inSection: 0) != 0 {
                        this.tableView.scrollToRow(at: IndexPath.zero, at: .top, animated: true)
                    }
                case .failure(let error):
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(PlaylistCell.self)
        guard let viewModel = try? viewModel.viewModelForItem(at: indexPath) else { return UITableViewCell() }
        cell.viewModel = viewModel
        return cell
    }
}
