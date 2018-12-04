//
//  ContainerCell.swift
//  Marvel
//
//  Created by Carbon on 03/12/2018.
//

import UIKit

class ContainerCell: UITableViewCell, ModelPresenterCell {

    var model: Comics?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            self.collectionView.registerNib(for: ComicCell.self)
        }
    }
    
}

extension ContainerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCell.reuseIdentifier, for: indexPath) as! ComicCell
        cell.model = model?.items[indexPath.row]
        return cell
//        return collectionView.reusableCell(for: indexPath, with: self.model?.items[indexPath.row]) as ComicCell
    }
}
