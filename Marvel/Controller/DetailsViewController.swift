//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Carbon on 02/12/2018.
//

import UIKit

protocol DetailsViewDelegate {
    func favouriteCharacterButtonPressed()
}

class DetailsViewController: StaticTableController {

    var delegate: DetailsViewDelegate?
    var result: Result!
    let cellCharacter = CharacterCell.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = result.name
        self.tableView.registerNib(for: CharacterCell.self)
        
        
        self.cellCharacter.set(result: self.result)
        self.cellCharacter.delegate = self
        self.dataSource.append(self.cellCharacter)
    }
    
}

extension DetailsViewController: CharacterCellDelegate {
    func favouriteCharacterButtonPressed() {
        self.delegate?.favouriteCharacterButtonPressed()
    }
}
