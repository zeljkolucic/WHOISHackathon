//
//  SearchResultManager.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import UIKit

let sharedSearchResultManager = SearchResultManager()

class SearchResultManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var searchResults = [SearchResult]()
    
    init() {
        fetchItems()
    }
    
    func fetchItems() {
        do {
            searchResults = try context.fetch(SearchResult.fetchRequest())
        } catch {
            print("Error fetching data from local database, \(error)")
        }
    }
    
    func insertItem(value: String) {
        fetchItems()
        var exists = false
        for i in 0..<searchResults.count {
            if searchResults[i].searchValue == value {
                sharedSearchResultManager.updateItem(searchResult: searchResults[i])
                exists = true
                break
            }
        }
        
        if !exists {
            let searchResult = SearchResult(context: context)
            searchResult.searchValue = value
            searchResult.date = Date()
            
            do {
                try context.save()
            } catch {
                print("Error saving data to local database, \(error)")
            }
        }
    }
    
    func clear() {
        fetchItems()
        for i in 0..<searchResults.count {
            context.delete(searchResults[i])
        }
        
        do {
            try context.save()
        } catch {
            print("Error")
        }
    }
    
    func updateItem(searchResult: SearchResult) {
        searchResult.date = Date()
        
        do {
            try context.save()
        } catch {
            print("Error saving data to local database, \(error)")
        }
    }
    
    
    
}
