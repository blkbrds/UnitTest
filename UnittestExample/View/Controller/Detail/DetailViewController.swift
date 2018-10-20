//
//  DetailViewController.swift
//  MyApp
//
//  Created by Hai Nguyen H.P. on 2/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift
import SKPhotoBrowser

final class DetailViewController: ViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var collectionThumbnail: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionThumbnail()
    }

    private func configCollectionThumbnail() {
        collectionThumbnail.register(nibWithCellClass: ThumbnailCell.self)
        collectionThumbnail.dataSource = self
        collectionThumbnail.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Config.sizeThumbnailCell
        layout.minimumLineSpacing = Config.minimumLineSpacing
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = Config.minimumInteritemSpacing
        collectionThumbnail.collectionViewLayout = layout
    }

    // MARK: - IBAction
    @IBAction private func seeMoreButtonTouchUpInside(sender: UIButton) {
    }
}
// MARK: - DetailViewModelDelegate
extension DetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: ThumbnailCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {

    private func showPhotoBrowser(at index: Int) {
//        let browser = SKPhotoBrowser(photos: viewModel.images, initialPageIndex: index)
//        present(browser, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showPhotoBrowser(at: indexPath.row)
    }
}

extension DetailViewController {
    struct Config {
        static let radius = 1_700.0
        static let cornerCodeLabel: CGFloat = 10
        static let cornerCollectionView: CGFloat = 20
        static let sizeTextButton: CGFloat = 12
        static let colorTextButton: UIColor = .blue
        static let sizeThumbnailCell = CGSize(width: SwifterSwift.screenWidth,
                                              height: SwifterSwift.screenHeight * 2 / 3)
        static let widthIconCell: CGFloat = 55
        static let minimumLineSpacing: CGFloat = 0
        static let minimumInteritemSpacing: CGFloat = 0
        static let maxLine = 0
        static let minLine = 9
    }
}
