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
    
    private var characters = [Result]()
    private var filterCharacters = [Result]()
    private var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupTableView()
        getCharacters()
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
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func showDetailsViewController(indexPath: IndexPath) {
        var result: Result?
        
        if isFiltering() {
            result = filterCharacters[indexPath.row]
        } else {
            result = characters[indexPath.row]
        }
        
        let detailsViewController = DetailsViewController()
        detailsViewController.result = result
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func getCharacters() {
        NetworkManager().getCharacters(page: page, onSuccess: { [weak self] (response) in
            self?.characters.append(contentsOf: response.data.results)
            self?.filterCharacters = response.data.results
            self?.page += 1
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }, onError: {}) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
}

// MARK: - Search Bar methods
extension HomeViewController {
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filterCharacters = characters.filter({( result : Result) -> Bool in
            return result.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
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
        
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        cell.delegate = self
        
        if isFiltering() {
            cell.model = filterCharacters[indexPath.row]
        } else {
            cell.model = characters[indexPath.row]
        }
        
        return cell
//        return tableView.reusableCell(for: indexPath.row, with: filterCharacters[indexPath.row]) as CharacterCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailsViewController(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isFiltering() == false, indexPath.row == characters.count - 2 {
            getCharacters()
            tableView.tableFooterView?.isHidden = false
        }
    }
    
}

extension HomeViewController: CharacterCellDelegate {
    func favouriteCharacterButtonPressed() {
        tableView.reloadData()
    }
}
