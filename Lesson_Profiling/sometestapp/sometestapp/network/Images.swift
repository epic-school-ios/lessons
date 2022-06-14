//
//  Images.swift
//  sometestapp
//
//  Created by Yuriy on 31.03.2022.
//

import Foundation

class Images {
    func getImages(completion: @escaping ([String]) -> Void) {
        let url = URL(string: "https://api.github.com/organizations")
        var request =  URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                    guard let data = data else {return}
                    
                    let decoder = JSONDecoder()
                    let picture = try? decoder.decode(Picture.self, from: data)
                    
                   // print(picture?[0].url)
                    
                    if let picture = picture {
                        completion(picture.map { $0.url })
                    } else {
                        completion([])
                    }
                    
                    
                    
//                    print(String(data: data, encoding: .utf8)!)
                } else {
                    
                    guard let data = data else {return}
                    print("Error:" + String(httpResponse.statusCode))
                    
                }
            }
        }
        
        task.resume()
    }
}


struct PictureElement: Codable {
    //    let breeds: [JSONAny]
    //    let categories: [Category]
    let id: String
    let url: String
    let width, height: Int
}
struct Category: Codable {
    let id: Int
    let name: String
}

typealias Picture = [PictureElement]
