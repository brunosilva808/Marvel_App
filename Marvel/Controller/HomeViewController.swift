//
//  HomeViewController.swift
//  Marvel
//
//  Created by Bruno Silva on 16/11/2018.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UITableViewController {

    private var searchController = UISearchController(searchResultsController: nil)
    
    private var character: Character?
    private var filterCharacters = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupTableView()
        
        NetworkManager().getCharacters(page: 0, onSuccess: { [weak self] (response) in
            self?.character = response
            self?.filterCharacters = response.data.results
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }) {
            
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerNib(for: CharacterCell.self)
    }
    
    func showDetailsViewController(indexPath: IndexPath) {
        var result: Result?
        
        if isFiltering() {
            result = filterCharacters[indexPath.row]
        } else {
            result = character?.data.results[indexPath.row]
        }
        
        let detailsViewController = DetailsViewController()
        detailsViewController.result = result
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

// MARK: - Search Bar methods
extension HomeViewController {
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if let results = character?.data.results {
            filterCharacters = results.filter({( result : Result) -> Bool in
                return result.name.lowercased().contains(searchText.lowercased())
            })
            
            tableView.reloadData()
        }
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(text)
        }
    }
    
}

// MARK: TableViewDelegate & TableViewDataSource
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterCharacters.count
        }
        
        return character?.data.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        
        if isFiltering() {
            cell.model = filterCharacters[indexPath.row]
        } else {
            cell.model = character?.data.results[indexPath.row]
        }
        
        return cell
//        return tableView.reusableCell(for: indexPath.row, with: filterCharacters[indexPath.row]) as CharacterCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailsViewController(indexPath: indexPath)
    }
    
}
