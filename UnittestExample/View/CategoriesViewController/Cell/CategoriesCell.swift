//
//  CategoriesCell.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

final class CategoriesCell: TableCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!

    var viewModel = CategoriesCellViewModel() {
        didSet {
            updateView()
        }
    }

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }

    func updateView() {
        titleLabel.text = viewModel.snipet.title
    }
}
