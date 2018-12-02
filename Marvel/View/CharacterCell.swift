//
//  CharacterCell.swift
//  Marvel
//
//  Created by Carbon on 02/12/2018.
//

import UIKit

class CharacterCell: UITableViewCell, ModelPresenterCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    var model: Result? {
        didSet {
            guard let model = self.model else { return }
            titleLabel.text = model.name
            let urlString = Service.shared.getImageUrl(thumbnail: model.thumbnail, size: APIConstant.Portrait.small)
            characterImageView.loadImageUsingUrlString(urlString: urlString)
//            characterImageView.loadImageUsingUrlString(urlString: model.)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
