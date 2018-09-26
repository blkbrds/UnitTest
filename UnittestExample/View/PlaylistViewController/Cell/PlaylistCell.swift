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

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailView.image = nil
    }

    private func updateView() {
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.description
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: self.viewModel.path), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.thumbnailView.image = UIImage(data: data)
                }
            }
        }
    }
}
