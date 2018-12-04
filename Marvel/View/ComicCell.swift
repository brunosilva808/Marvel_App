//
//  ComicCell.swift
//  Marvel
//
//  Created by Carbon on 04/12/2018.
//

import UIKit

class ComicCell: UICollectionViewCell, ModelPresenterCell {

    var model: ComicsItem?
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
//            let urlString = Service.shared.getImageUrl(thumbnail: model.thumbnail, size: APIConstant.Portrait.small)
//            self.characterImageView.loadImageUsingUrlString(urlString: urlString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
