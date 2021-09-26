//
//  SearchResult+CoreDataProperties.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//
//

import Foundation
import CoreData


extension SearchResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResult> {
        return NSFetchRequest<SearchResult>(entityName: "SearchResult")
    }

    @NSManaged public var searchValue: String?
    @NSManaged public var date: Date?

}

extension SearchResult : Identifiable {

}
