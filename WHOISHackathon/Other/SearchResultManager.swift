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
    
    func fetchItems() -> [SearchResult] {
        var searchResults = [SearchResult]()
        do {
            searchResults = try context.fetch(SearchResult.fetchRequest())
        } catch {
            print("Error fetching data from local database, \(error)")
        }
        return searchResults
    }
    
    func insertItem(value: String) {
        let searchResult = SearchResult(context: context)
        searchResult.searchValue = value
        searchResult.date = Date()
        
        do {
            try context.save()
        } catch {
            print("Error saving data to local database, \(error)")
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
