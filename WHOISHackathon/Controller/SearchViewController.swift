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
        searchController.searchBar.placeholder = "Pretrazite.."
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        navigationItem.searchController = searchController
    }
    
    @objc private func navigateToDomain() {
        DispatchQueue.main.async {
            if let domainDetail = sharedNetworkManager.domainData {
                self.navigationController?.pushViewController(DomainViewController(domainDetail), animated: true)
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchValue = searchBar.text {
            sharedSearchResultManager.insertItem(value: searchValue)
            sharedNetworkManager.fetchDomainItems(domainName: searchValue)
            
            let name = Notification.Name(rawValue: Notifications.notificationKey)
            NotificationCenter.default.addObserver(self, selector: #selector(navigateToDomain), name: name, object: nil)
        }
    }
    
}
