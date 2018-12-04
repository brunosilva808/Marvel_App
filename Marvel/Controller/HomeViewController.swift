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
    
    private let transition = PopAnimator()
    private var indexPath: IndexPath!
    private var characters = [Result]()
    private var filterCharacters = [Result]()
    private var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearchController()
        self.setupTableView()
        self.getCharacters()
    }
    
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.registerNib(for: CharacterCell.self)
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func showDetailsViewController(indexPath: IndexPath) {
        var result: Result?
        
        if isFiltering() {
            result = self.filterCharacters[indexPath.row]
        } else {
            result = self.characters[indexPath.row]
        }
        
        let detailsViewController = DetailsViewController()
        detailsViewController.result = result
        detailsViewController.transitioningDelegate = self
        detailsViewController.delegate = self
        present(detailsViewController, animated: true, completion: nil)
    }
    
    func getCharacters() {
        NetworkManager().getCharacters(page: page, onSuccess: { [weak self] (response) in
            self?.characters.append(contentsOf: response.data.results)
            self?.filterCharacters = response.data.results
            self?.page += 1
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }, onError: {error in
            print(error)
        }) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
}

// MARK: - Search Bar methods
extension HomeViewController {
    
    private func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.filterCharacters = characters.filter({( result : Result) -> Bool in
            return result.name.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return self.searchController.isActive && !self.searchBarIsEmpty()
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            self.filterContentForSearchText(text)
        }
    }
    
}

// MARK: TableViewDelegate & TableViewDataSource
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering() {
            return self.filterCharacters.count
        }
        
        return self.characters.count
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
        self.indexPath = indexPath
        self.showDetailsViewController(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isFiltering() == false, indexPath.row == characters.count - 2 {
            self.getCharacters()
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
}

extension HomeViewController: CharacterCellDelegate, DetailsViewDelegate {
    func favouriteCharacterButtonPressed() {
        self.tableView.reloadData()
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.presenting = true
        
        let rectOfCellInTableView = tableView.rectForRow(at: self.indexPath)
        let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
        
        transition.originFrame = rectOfCellInSuperview
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
        
    }
    
}
