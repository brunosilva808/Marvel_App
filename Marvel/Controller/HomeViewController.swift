//
//  HomeViewController.swift
//  Marvel
//
//  Created by Bruno Silva on 16/11/2018.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableView.automaticDimension
            tableView.registerNib(for: CharacterCell.self)
        }
    }
    
    var character: Character? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        NetworkManager().getCharacters(page: 0, onSuccess: { [weak self] (response) in
            self?.character = response
        }) {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? FullScreenViewController,
           let indexPath = sender as? IndexPath {
//            destinationViewController.result = comics?.data.results[indexPath.row]
        }
    }
    
    func setupTableView() {
        
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character?.data.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        cell.model = character?.data.results[indexPath.row]
        return cell
//        return tableView.reusableCell(for: indexPath.row, with: character?.data.results[indexPath.row]) as CharacterCell
    }
    
}
