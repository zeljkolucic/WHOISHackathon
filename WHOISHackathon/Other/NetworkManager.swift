//
//  NetworkManager.swift
//  WHOISHackathon
//
//  Created by Zeljko Lucic on 25.9.21..
//

import Foundation

let sharedNetworkManager = NetworkManager()

class NetworkManager {
    
    private let url = "http://hakaton.redtech.cc/WhoIs/"
    
    var domainData: DomainDetail?
    var mostSearchedDomains: [DomainDetail]?
    
    func fetchDomainItems(domainName: String) {
        let urlString = "\(url)?domain=\(domainName)"
        performRequest(urlString: urlString)
    }
    
    func randomDomain() {
        let urlString = "\(url)random"
        performRequest(urlString: urlString)
    }
    
    func getMostSearchedDomains() {
        let urlString = "\(url)popular"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.mostSearchedDomains = try decoder.decode([DomainDetail].self, from: data)
                        let name = Notification.Name.init(Notifications.mostSearchedNotificationKey)
                        NotificationCenter.default.post(name: name, object: nil)
                    } catch {
                        print("Error fetching data from server, \(error)")
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.domainData = try decoder.decode(DomainDetail.self, from: data)
                        let name = Notification.Name.init(Notifications.notificationKey)
                        NotificationCenter.default.post(name: name, object: nil)
                    } catch {
                        print("Error fetching data from server, \(error)")
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func sendEmailRequest(emailAddress: String, domainName: String) {
        var urlString = "\(url)email/"
        urlString.append("?email=\(emailAddress)")
        urlString.append("&domainname=\(domainName)")
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
            }
            task.resume()
        }
    }
    
}
