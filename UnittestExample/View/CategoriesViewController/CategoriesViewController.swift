//
//  CategoriesViewController.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit
import SwiftUtils

final class CategoriesViewController: ViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    var viewModel = CategoriesViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        getCategories()
        title = "Categories"
    }

    // MARK: Private func
    private func configTableView() {
        tableView.register(CategoriesCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getCategories() {
        viewModel.getCategories { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
}

extension CategoriesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlaylistViewController()
        guard let viewModel = try? viewModel.playlistViewModel(at: indexPath) else { return }
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension CategoriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CategoriesCell.self)
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}
