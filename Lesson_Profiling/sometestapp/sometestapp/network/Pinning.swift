//
//  Pinning.swift
//  sometestapp
//
//  Created by Yuriy on 29.03.2022.
//

import Foundation

class Pinning: NSObject, DataProtocol {
    private lazy var certificates: [Data] = {
        let url = Bundle.main.url(forResource: "ssl", withExtension: "cer")!
        let data = try! Data(contentsOf: url)
        return [data]
    }()

    
    func fetchData() {
        let url = URL(string: "https://ipinfo.io/8.8.8.8")!
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            
            print(String(data: data!, encoding: .utf8))
        }
        
        task.resume()
    }
}



//https://developer.apple.com/news/?id=g9ejcf8y
