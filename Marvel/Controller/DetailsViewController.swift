//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Bruno Silva on 02/12/2018.
//

import UIKit

class DetailsViewController: StaticTableController {
    
    var delegate: FavouriteCharacterDelegate?
    var result: Result!
    let cellCharacter = CharacterCell.fromNib()
    let cellContainer1 = ContainerCell.fromNib()
    let cellContainer2 = ContainerCell.fromNib()
    let cellContainer3 = ContainerCell.fromNib()
    let cellContainer4 = ContainerCell.fromNib()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = result.name
        self.tableView.registerNib(for: CharacterCell.self)
        self.tableView.registerNib(for: ContainerCell.self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tap)
        
        self.cellCharacter.model = self.result
        self.cellCharacter.delegate = self
        self.cellContainer1.set(title: "Comics")
        self.cellContainer2.set(title: "Events")
        self.cellContainer3.set(title: "Stories")
        self.cellContainer4.set(title: "Series")
        self.dataSource.append(self.cellCharacter)
        
        self.getComics()
        self.getEvents()
        self.getSeries()
        self.getStories()
        
        self.dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    @objc func handleTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getComics() {
        if let url = result.comics?.collectionURI {
            self.dispatchGroup.enter()
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (data) in
                if data.results.count > 0 {
                    self?.cellContainer1.model = data.results
                    if let cell = self?.cellContainer1 {
                        self?.dataSource.append(cell)
                    }
                }
                }, onError: { (error) in
                    print(error)
            }) {  [weak self] in
                self?.dispatchGroup.leave()
            }
        }
    }

    func getEvents() {
        if let url = result.events?.collectionURI {
            self.dispatchGroup.enter()
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (data) in
                if data.results.count > 0 {
                    self?.cellContainer2.model = data.results
                    if let cell = self?.cellContainer2 {
                        self?.dataSource.append(cell)
                    }
                }

                }, onError: {(_) in
            }) { [weak self] in
                self?.dispatchGroup.leave()
            }
        }
    }

    func getStories() {
        if let url = result.stories?.collectionURI {
            self.dispatchGroup.enter()
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (data) in
                if data.results.count > 0 {
                    self?.cellContainer3.model = data.results
                    if let cell = self?.cellContainer3 {
                        self?.dataSource.append(cell)
                    }
                }

                }, onError: {(_) in
            }) { [weak self] in
                self?.dispatchGroup.leave()
            }
        }
    }

    func getSeries() {
        if let url = result.series?.collectionURI {
            self.dispatchGroup.enter()
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (data) in
                if data.results.count > 0 {
                    self?.cellContainer4.model = data.results
                    if let cell = self?.cellContainer4 {
                        self?.dataSource.append(cell)
                    }
                }

                }, onError: { (_) in
            }) { [weak self] in
                self?.dispatchGroup.leave()
            }
        }
    }
    
}

extension DetailsViewController: FavouriteCharacterDelegate {
    func favouriteCharacterButtonPressed() {
        self.delegate?.favouriteCharacterButtonPressed()
    }
}
