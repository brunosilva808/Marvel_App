//
//  ContainerCell.swift
//  Marvel
//
//  Created by Bruno Silva on 03/12/2018.
//

import UIKit

class ContainerCell: UITableViewCell, ModelPresenterCell {

    var model: [Result1]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            self.collectionView.collectionViewLayout = layout
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            self.collectionView.registerNib(for: ComicCell.self)
        }
    }
    
    func set(title: String) {
        self.titleLabel.text = title
    }
    
}

extension ContainerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCell.reuseIdentifier, for: indexPath) as! ComicCell
        cell.model = model?[indexPath.row]
        return cell
//        return collectionView.reusableCell(for: indexPath, with: self.model?.items[indexPath.row]) as ComicCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 190)
    }
}
