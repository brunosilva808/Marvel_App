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
    let cellContainer1 = ContainerCell.fromNib()
    let cellContainer2 = ContainerCell.fromNib()
    let cellContainer3 = ContainerCell.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = result.name
        self.tableView.registerNib(for: CharacterCell.self)
        self.tableView.registerNib(for: ContainerCell.self)
        
        self.cellCharacter.model = self.result
        self.cellCharacter.delegate = self
        self.cellContainer1.model = self.result.comics
        self.dataSource.append(contentsOf: [self.cellCharacter, self.cellContainer1])
        
        NetworkManager().getResourceUri(urlString: result.comics.collectionURI, onSuccess: { (response) in
            print(response)
        }, onError: { (error) in
            print(error)
        }) {}
    }
    
}

extension DetailsViewController: CharacterCellDelegate {
    func favouriteCharacterButtonPressed() {
        self.delegate?.favouriteCharacterButtonPressed()
    }
}
