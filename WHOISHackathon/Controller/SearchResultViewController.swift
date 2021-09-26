//
//  SearchResultViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

class SearchResultViewController: UIViewController {
    
    private var searchResults = [SearchResult]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
    }
    
    private func setConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func fetchItems() {
        sharedSearchResultManager.fetchItems()
        searchResults = sharedSearchResultManager.searchResults
        tableView.reloadData()
    }
    
    @objc private func navigateToDomain() {
        DispatchQueue.main.async {
            if let domainDetail = sharedNetworkManager.domainData {
                //self.navigationController?.pushViewController(DomainViewController(domainDetail), animated: true)
                self.present(DomainViewController(domainDetail), animated: true, completion: nil)
            }
        }
    }
    
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].searchValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let searchValue = searchResults[indexPath.row].searchValue {
            sharedSearchResultManager.insertItem(value: searchValue)
            sharedNetworkManager.fetchDomainItems(domainName: searchValue)
            
            let name = Notification.Name(rawValue: Notifications.notificationKey)
            NotificationCenter.default.addObserver(self, selector: #selector(navigateToDomain), name: name, object: nil)
        }
    }
    
}
