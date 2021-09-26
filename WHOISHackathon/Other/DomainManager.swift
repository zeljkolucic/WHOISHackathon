//
//  DomainManager.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 26.9.21..
//

import UIKit
import CoreData

let sharedDomainManager = DomainManager()

class DomainManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var domainItems = [DomainItem]()
    
    init() {
        fetchItems()
    }
    
    func fetchItems() {
        do {
            domainItems = try context.fetch(DomainItem.fetchRequest())
        } catch {
            print("Error fetching data from local database, \(error)")
        }
    }
    
    func insertItem(_ domainDetail: DomainDetail) {
        fetchItems()
        
        for i in 0..<domainItems.count {
            if domainDetail.name == domainItems[i].name {
                return
            }
        }
        
        let domainItem = DomainItem(context: context)
        domainItem.name = domainDetail.name
        
        do {
            try context.save()
        } catch {
            print("Error saving data to local database, \(error)")
        }
    }
    
    func deleteItem(_ name: String) {
        for i in 0..<domainItems.count {
            if domainItems[i].name == name {
                context.delete(domainItems[i])
            }
        }
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
}
