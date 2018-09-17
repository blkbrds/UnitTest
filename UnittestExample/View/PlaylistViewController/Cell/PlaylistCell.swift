//
//  PlaylistCell.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

final class PlaylistCell: TableCell {

    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    var viewModel = PlaylistCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailView.image = nil
    }

    private func configView() {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.description
        if let url = URL(string: viewModel.path), let data = try? Data(contentsOf: url) {
            thumbnailView.image = UIImage(data: data)
        }
    }

    private func updateView() {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.description
        if let url = URL(string: viewModel.path), let data = try? Data(contentsOf: url) {
            thumbnailView.image = UIImage(data: data)
        }
    }
}
