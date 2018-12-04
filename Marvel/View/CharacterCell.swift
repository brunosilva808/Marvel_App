//
//  CharacterCell.swift
//  Marvel
//
//  Created by Bruno Silva on 02/12/2018.
//

import UIKit

protocol FavouriteCharacterDelegate {
    func favouriteCharacterButtonPressed()
}

class CharacterCell: UITableViewCell, ModelPresenterCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            self.characterImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var favouriteButton: UIButton! {
        didSet {
            self.favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        }
    }
    
    var delegate: FavouriteCharacterDelegate?
    var model: Result? {
        didSet {
            guard let model = self.model else { return }
            
            self.titleLabel.text = model.name
            self.characterImageView.loadImageUsingUrlString(urlString: model.thumbnail.getImageUrl(size: .small))
            self.selectFavouriteCharacter()
        }
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
        guard var id = model?.id else { return }
        
        if let favouriteId = UserDefaultsDataSource().readData(for: UserDefaultsKeys.favouriteCharacter),
        let favourite = favouriteId as? Int,
        favourite == id {
            id = 0
        }
        
        UserDefaultsDataSource().writeData(id, for: UserDefaultsKeys.favouriteCharacter)
        self.selectFavouriteCharacter()
        self.delegate?.favouriteCharacterButtonPressed()
    }
}
