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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistorySearchCell")
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
        navigationItem.title = Strings.history
        
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func fetchItems() {
        searchResults = sharedSearchResultManager.fetchItems()
        tableView.reloadData()
    }
        
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySearchCell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].searchValue
        let details = UITextView()
        if let date = searchResults[indexPath.row].date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            details.text = dateFormatter.string(from: date)
            cell.accessoryView = details
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
