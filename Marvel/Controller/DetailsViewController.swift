//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Bruno Silva on 02/12/2018.
//

import UIKit

protocol DetailsViewDelegate {
    func favouriteCharacterButtonPressed()
}

class DetailsViewController: StaticTableController {

    var delegate: DetailsViewDelegate?
    var result: Result!
    var apiHelper = APICallHelper()
    let cellCharacter = CharacterCell.fromNib()
    let cellContainer1 = ContainerCell.fromNib()
    let cellContainer2 = ContainerCell.fromNib()
    let cellContainer3 = ContainerCell.fromNib()
    let cellContainer4 = ContainerCell.fromNib()
    
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
        
        self.getData()
        
        self.apiHelper.onCompletion = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
 
    @objc func handleTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getData() {
        if let url = result.comics?.collectionURI {
            self.apiHelper.started(request: .comics)
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (response) in
                if response.data.results.count > 0 {
                    self?.cellContainer1.model = response.data.results
                    if let cell = self?.cellContainer1 {
                        self?.dataSource.append(cell)
                    }
                }
                
                self?.apiHelper.finished(request: .comics, success: true)
                }, onError: { [weak self] (error) in
                    self?.apiHelper.finished(request: .comics, success: false)
            }) {}
        }
        
        if let url = result.events?.collectionURI {
            self.apiHelper.started(request: .events)
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (response) in
                if response.data.results.count > 0 {
                    self?.cellContainer2.model = response.data.results
                    if let cell = self?.cellContainer2 {
                        self?.dataSource.append(cell)
                    }
                }
                
                self?.apiHelper.finished(request: .events, success: true)
                }, onError: { [weak self] (error) in
                    self?.apiHelper.finished(request: .events, success: false)
            }) {}
        }
        
        if let url = result.stories?.collectionURI {
            self.apiHelper.started(request: .stories)
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (response) in
                if response.data.results.count > 0 {
                    self?.cellContainer3.model = response.data.results
                    if let cell = self?.cellContainer3 {
                        self?.dataSource.append(cell)
                    }
                }
                
                self?.apiHelper.finished(request: .stories, success: true)
            }, onError: { [weak self] (error) in
                self?.apiHelper.finished(request: .stories, success: false)
            }) {}
        }
        
        if let url = result.series?.collectionURI {
            self.apiHelper.started(request: .series)
            NetworkManager().getResourceUri(urlString: url, onSuccess: { [weak self] (response) in
                if response.data.results.count > 0 {
                    self?.cellContainer4.model = response.data.results
                    if let cell = self?.cellContainer4 {
                        self?.dataSource.append(cell)
                    }
                }
                
                self?.apiHelper.finished(request: .series, success: true)
                }, onError: { [weak self] (error) in
                    self?.apiHelper.finished(request: .series, success: false)
            }) {}
        }
    }
}

extension DetailsViewController: CharacterCellDelegate {
    func favouriteCharacterButtonPressed() {
        self.delegate?.favouriteCharacterButtonPressed()
    }
}
