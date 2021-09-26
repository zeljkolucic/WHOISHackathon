//
//  LaunchViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

class HomeViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var favorites = [DomainItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        setupLayout()
        setConstraints()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        navigationItem.title = Strings.home
        
        view.addSubview(searchBar)
    }
    
    private func setConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func saveData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(favorites)
            try data.write(to: sharedNetworkManager.plistURL)
            
        } catch {
            print("Error encoding domain items array, \(error)")
        }
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.pushViewController(SearchViewController(), animated: true)
        searchBar.setShowsCancelButton(false, animated: false)
        return false
    }
    
}
