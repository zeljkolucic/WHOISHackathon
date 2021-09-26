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
    
    let plistURL: URL = {
        let document = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return document.appendingPathComponent("DomainItems.plist")
    }()
    
    func fetchDomainItems(domainName: String) {
        print(domainName)
        let urlString = "\(url)?domain=\(domainName)"
        performRequest(urlString: urlString)
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
                    let dataString = String(data: data, encoding: .utf8)
                    print(dataString)
                    self.parseJSON(data: data)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DomainItem.self, from: data)
        } catch {
            print(error)
        }
        
    }
    
}
