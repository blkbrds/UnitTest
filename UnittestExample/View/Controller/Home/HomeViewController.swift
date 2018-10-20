//
//  HomeViewController.swift
//  Tutorial
//
//  Created by Hai Nguyen H.P. on 11/29/17.
//  Copyright © 2017 Hai Nguyen H.P. All rights reserved.
//

import UIKit
import SwifterSwift

final class HomeViewController: ViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!

    private var loadmoreIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 25, height: 25)))
        indicatorView.color = .darkGray
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        configCollectionView()
    }

    private func configCollectionView() {
        collectionView.register(nibWithCellClass: PromotionGridCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionElementKindSectionFooter, withClass: UICollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        setLayoutCollectionView()
    }

    private func setLayoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Config.minimumLineSpacing
        layout.sectionInset = Config.sectionInset
        layout.minimumInteritemSpacing = Config.minimumInteritemSpacing
        layout.itemSize = Config.sizeGrid
        layout.footerReferenceSize = CGSize(width: collectionView.frame.width, height: 20)
        collectionView.collectionViewLayout = layout
    }

    private func reloadData() {
        collectionView.reloadData()
    }
}
// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: PromotionGridCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: UICollectionViewCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        footer.addSubview(loadmoreIndicatorView)
        return footer
    }
}
// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0, animations: { () -> Void in
            cell.transform = Config.scaleMini
        }, completion: { (_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                cell.transform = Config.scaleNormal
            })
        })
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc)
    }
}

extension HomeViewController {

    struct Config {
        static let sizeGrid = CGSize(width: (SwifterSwift.screenWidth - 55) / 2, height: SwifterSwift.screenHeight / 3)
        static let sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        static let minimumLineSpacing: CGFloat = 16
        static let minimumInteritemSpacing: CGFloat = 0
        static let scaleMini = CGAffineTransform(a: 0.1, b: 0, c: 0, d: 0.1, tx: 1, ty: 0)
        static let scaleNormal = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    }
}
