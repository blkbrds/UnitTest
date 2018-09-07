//
//  MoviesViewController.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import UIKit
import SwiftUtils

private struct Configuration {
    static let heightForRow: CGFloat = 60
}

final class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviesCell.self)
    }

}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Configuration.heightForRow
    }
}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = tableView.dequeue(MoviesCell.self)
            cell.viewModel = viewModel
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
}

