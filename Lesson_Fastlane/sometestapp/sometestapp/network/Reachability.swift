//
//  Reachability.swift
//  sometestapp
//
//  Created by Yuriy on 29.03.2022.
//

import Foundation
import Network

class Reachability: DataProtocol {
    private let monitor = NWPathMonitor()
    
    func fetchData() {
        monitor.cancel()
        monitor.start(queue: DispatchQueue(label: "monitor"))
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.monitor.cancel()
            
            if path.status == .satisfied {
                self?.sendRequest()
            }
        }
    }
    
    private func sendRequest() {
        let url = URL(string: "https://ipinfo.io/8.8.8.8")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            
            print(String(data: data!, encoding: .utf8))
        }
        
        task.resume()
    }
}
