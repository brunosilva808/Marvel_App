//
//  CharacterCell.swift
//  Marvel
//
//  Created by Carbon on 02/12/2018.
//

import UIKit

protocol CharacterCellDelegate {
    func favouriteCharacterButtonPressed()
}

class CharacterCell: UITableViewCell, ModelPresenterCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
 
    var delegate: CharacterCellDelegate?
    var model: Result? {
        didSet {
            guard let model = self.model else { return }
            
            self.titleLabel.text = model.name
            let urlString = Service.shared.getImageUrl(thumbnail: model.thumbnail, size: APIConstant.Portrait.small)
            self.characterImageView.loadImageUsingUrlString(urlString: urlString)
            self.selectFavouriteCharacter()
        }
    }
    
    func set(result: Result) {
        self.model = result
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
    }

    func selectFavouriteCharacter() {
        guard let id = model?.id,
        let favouriteId = UserDefaultsDataSource().readData(for: UserDefaultsKeys.favouriteCharacter),
        let favourite = favouriteId as? Int else { return }
        
        if favourite == id {
            self.favouriteButton.setImage(UIImage(named: "star_full"), for: .normal)
        } else {
            self.favouriteButton.setImage(UIImage(named: "star_empty"), for: .normal)
        }
    }
}

extension CharacterCell {
    @objc func favouriteButtonPressed() {
        guard let id = model?.id else { return }
        
        UserDefaultsDataSource().writeData(id, for: UserDefaultsKeys.favouriteCharacter)
        self.selectFavouriteCharacter()
        self.delegate?.favouriteCharacterButtonPressed()
    }
}
