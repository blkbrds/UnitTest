//
//  MoviesCell.swift
//  QuickDemo
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import UIKit

final class MoviesCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    var viewModel = MoviesCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }

    private func updateView() {
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.description
        avatarImageView.setImage(urlString: viewModel.image, placeholder: nil)
    }
}
