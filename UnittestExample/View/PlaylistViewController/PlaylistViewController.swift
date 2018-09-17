//
//  PlaylistViewController.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

final class PlaylistViewController: ViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    var viewModel = PlaylistViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        getPlaylist()
        title = "Playlist"
    }

    // MARK: Private func
    private func configTableView() {
        tableView.register(PlaylistCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func getPlaylist() {
        viewModel.getPlaylist { [weak self] result in
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

extension PlaylistViewController: UITableViewDelegate {}

extension PlaylistViewController: UITableViewDataSource {

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
