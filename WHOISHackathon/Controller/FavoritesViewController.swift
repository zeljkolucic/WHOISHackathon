//
//  FavoritesViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteDomainCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AppBlue")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewControllerTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont(name: Fonts.mainFont, size: 28)
        title.text = Strings.favorites
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var favorites = [DomainItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        
        view.addSubview(topContainerView)
        topContainerView.addSubview(viewControllerTitle)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        viewControllerTitle.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        viewControllerTitle.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func fetchData() {
        sharedDomainManager.fetchItems()
        favorites = sharedDomainManager.domainItems
        tableView.reloadData()
    }
    
    @objc private func navigateToDomain() {
        DispatchQueue.main.async {
            if let domainDetail = sharedNetworkManager.domainData {
                self.present(DomainViewController(domainDetail), animated: true, completion: nil)
            }
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteDomainCell", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row].name
        cell.textLabel?.textColor = UIColor(named: "AppBlue")
        cell.textLabel?.font = UIFont(name: Fonts.mainFont, size: 18)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let domainName = favorites[indexPath.row].name {
            sharedNetworkManager.fetchDomainItems(domainName: domainName)
            
            let name = Notification.Name(rawValue: Notifications.notificationKey)
            NotificationCenter.default.addObserver(self, selector: #selector(navigateToDomain), name: name, object: nil)
        }
        
    }
    
}
