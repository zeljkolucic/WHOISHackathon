//
//  DomainItem+CoreDataProperties.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 26.9.21..
//
//

import Foundation
import CoreData


extension DomainItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DomainItem> {
        return NSFetchRequest<DomainItem>(entityName: "DomainItem")
    }

    @NSManaged public var information: String?
    @NSManaged public var name: String?
    @NSManaged public var domainId: String?
    @NSManaged public var createdDateInMiliseconds: Double
    @NSManaged public var updatedDateInMiliseconds: Double
    @NSManaged public var expirationDateInMiliseconds: Double
    @NSManaged public var nameServers: String?
    @NSManaged public var address: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var registarIanaId: String?
    @NSManaged public var registarName: String?
    @NSManaged public var url: String?
    @NSManaged public var abuseContactEmail: String?
    @NSManaged public var abuseContactPhone: String?
    @NSManaged public var registrantName: String?
    @NSManaged public var whoIsResponse: String?

}

extension DomainItem : Identifiable {

}
