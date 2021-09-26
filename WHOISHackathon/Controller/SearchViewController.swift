//
//  SearchViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        navigationItem.searchController = searchController
    }
    
    private func insertItem(value: String) {
        let searchResults = sharedSearchResultManager.fetchItems()
        var exists = false
        for i in 0..<searchResults.count {
            if searchResults[i].searchValue == value {
                sharedSearchResultManager.updateItem(searchResult: searchResults[i])
                exists = true
                break
            }
        }
        
        if !exists {
            sharedSearchResultManager.insertItem(value: value)
        }
    }
    
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchValue = searchBar.text {
            insertItem(value: searchValue)
            sharedNetworkManager.fetchDomainItems(domainName: searchValue)
        }
        
        
//        navigationController?.pushViewController(DomainViewController(), animated: true)
    }
    
}

