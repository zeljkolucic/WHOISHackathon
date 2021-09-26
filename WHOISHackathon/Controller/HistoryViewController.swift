//
//  HistoryViewController.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var searchResults = [SearchResult]()
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AppBlue")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.historySearch
        label.textColor = .white
        return label
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AppTheme")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "HistorySearchCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
       // configureBottomContainerView()
    }
    
    private func setConstraints() {
//        topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        topContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        topContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
//        topContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
//        headlineLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
//        headlineLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor).isActive = true
//        headlineLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor).isActive = true
        
//        bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
//        bottomContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        bottomContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        bottomContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func configureBottomContainerView() {
        let path = UIBezierPath(roundedRect: bottomContainerView.bounds,
                                byRoundingCorners:[.topLeft, .topRight],
                                cornerRadii: CGSize(width: 20, height:  20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        bottomContainerView.layer.mask = maskLayer
    }
    
    private func fetchItems() {
        sharedSearchResultManager.fetchItems()
        searchResults = sharedSearchResultManager.searchResults
        tableView.reloadData()
    }
    
    @objc private func navigateToDomain() {
        DispatchQueue.main.async {
            if let domainDetail = sharedNetworkManager.domainData {
                self.navigationController?.modalPresentationStyle = .overCurrentContext
                self.navigationController?.present(DomainViewController(domainDetail), animated: true, completion: nil)
            }
        }
    }
        
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySearchCell", for: indexPath) as! SearchResultCell
        cell.title.text = searchResults[indexPath.row].searchValue
        let date = DateFormatter.toString(date: searchResults[indexPath.row].date!)
        cell.date.text = "Pretraženo \(date)"
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
