//
//  PromotionCollectionCell.swift
//  MyApp
//
//  Created by Hai Nguyen H.P. on 2/22/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class PromotionGridCell: CollectionCell {

    // MARK: - IBOutlet
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var promotionTitleLabel: UILabel!
    @IBOutlet weak var promotionView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func detailButtonTouchUpInside(_ sender: UIButton) {
    }
}
