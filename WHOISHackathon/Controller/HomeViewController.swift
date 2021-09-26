//
//  LaunchViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

class HomeViewController: UIViewController {
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AppBlue")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Fonts.mainFont, size: 28)
        label.text = Strings.homeScreenLabel
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Strings.searchBarPlaceholder
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let inputField: UITextField = {
        let inputField = UITextField()
        inputField.layer.cornerRadius = 10
        inputField.backgroundColor = .white
        inputField.translatesAutoresizingMaskIntoConstraints = false
        return inputField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.searchBarPlaceholder, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.mainFont, size: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "AppLightGreen")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let feelingLuckyButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.feelingLucky, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.mainFont, size: 18)
        button.backgroundColor = UIColor(named: "AppLightGreen")
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mostFrequentLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.mostFrequent
        label.font = UIFont(name: Fonts.mainFont, size: 24)
        label.textColor = UIColor(named: "AppBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MostFrequentCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var mostSearchedDomains: [DomainDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        feelingLuckyButton.addTarget(self, action: #selector(feelingLuckyButtonPressed), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        getMostSearched()
        
        setupLayout()
        setConstraints()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(named: "AppTheme")
        topContainerView.addSubview(label)
        topContainerView.addSubview(inputField)
        topContainerView.addSubview(searchButton)
        topContainerView.addSubview(feelingLuckyButton)
        
        view.addSubview(topContainerView)
        view.addSubview(mostFrequentLabel)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topContainerView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 90).isActive = true
        label.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -30).isActive = true
        
        inputField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40).isActive = true
        inputField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        inputField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        inputField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: inputField.topAnchor).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 5).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        feelingLuckyButton.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 20).isActive = true
        feelingLuckyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feelingLuckyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        feelingLuckyButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        mostFrequentLabel.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 30).isActive = true
        mostFrequentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        mostFrequentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mostFrequentLabel.heightAnchor.constraint(equalToConstant: mostFrequentLabel.intrinsicContentSize.height + 10).isActive = true

        tableView.topAnchor.constraint(equalTo: mostFrequentLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc private func feelingLuckyButtonPressed() {
        sharedNetworkManager.randomDomain()
        
        DispatchQueue.main.async {
            if let domainDetail = sharedNetworkManager.domainData {
                self.present(DomainViewController(domainDetail), animated: true, completion: nil)
            }
        }
    }
    
    @objc private func navigateToDomain() {
        DispatchQueue.main.async {
            if let domainDetail = sharedNetworkManager.domainData {
                self.present(DomainViewController(domainDetail), animated: true, completion: nil)
            }
        }
    }
    
    @objc private func reloadData() {
        DispatchQueue.main.async {
            self.mostSearchedDomains = sharedNetworkManager.mostSearchedDomains!
            self.tableView.reloadData()
        }
    }
    
    @objc private func searchButtonPressed() {
        if inputField.text != nil && inputField.text != "" {
            let text = inputField.text!
            sharedNetworkManager.fetchDomainItems(domainName: text)
        }
        let name = Notification.Name(rawValue: Notifications.notificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDomain), name: name, object: nil)
    }

    private func getMostSearched() {
        sharedNetworkManager.getMostSearchedDomains()
        
        let name = Notification.Name(rawValue: Notifications.mostSearchedNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: name, object: nil)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.pushViewController(SearchViewController(), animated: true)
        searchBar.setShowsCancelButton(false, animated: false)
        return false
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedNetworkManager.mostSearchedDomains?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MostFrequentCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: Fonts.mainFont, size: 18)
        cell.textLabel?.textColor = UIColor(named: "AppBlue")
        if let mostSearchedDomains = sharedNetworkManager.mostSearchedDomains {
            cell.textLabel?.text = mostSearchedDomains[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let domainName = mostSearchedDomains[indexPath.row].name {
            sharedNetworkManager.fetchDomainItems(domainName: domainName)
            
            let name = Notification.Name(rawValue: Notifications.notificationKey)
            NotificationCenter.default.addObserver(self, selector: #selector(navigateToDomain), name: name, object: nil)
        }
    }
    
    
}
