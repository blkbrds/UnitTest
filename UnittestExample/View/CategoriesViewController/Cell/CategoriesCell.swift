//
//  CategoriesCell.swift
//  UnittestExample
//
//  Created by ToanTV on 9/12/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit

final class CategoriesCell: TableCell {

   var gotoProfile: (() -> Void)?

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!

    var viewModel = CategoriesCellViewModel() {
        didSet {
            updateView()
            viewModel.item.bind { [weak self] (item) in
                self?.titleLabel.text = item.snippet.title
            }
        }
    }

    @IBAction func buttonTouchUpInside(_ sender: UIButton?) {
        let value = viewModel.item.value
        value.snippet.title = "abc123"
        viewModel.item.value = value
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
