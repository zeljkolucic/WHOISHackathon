//
//  DomainItem.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import Foundation

class DomainItem: Codable {
    
    var information: Information?
    
}

class Information: Codable {
    
    var name: String?
    var domainId: String?
    var createdDate: String?
    var updatedDate: String?
    var expirationDate: String?
    var nameServers: String?
    var address: String?
    var postalCode: String?
    var registarIanaId: String?
    var registarName: String?
    var url: String?
    var abuseContactEmail: String?
    var abuseContactPhone: String?
    var registrantName: String?
    var whoIsResponse: String?
    
}
