//
//  Insecure.swift
//  sometestapp
//
//  Created by Yuriy on 29.03.2022.
//

import Foundation

class Insecure: DataProtocol {
    func fetchData() {
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
