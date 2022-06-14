//
//  GithubApi.swift
//  sometestapp
//
//  Created by Yuriy on 12.04.2022.
//

import Foundation
import UIKit

class GithubApi {
    func fetchData(completion: @escaping ([GithubOrganization]) -> Void) {
        print("Githubapi network")
        let url = URL(string: "https://api.github.com/organizations")
        var request =  URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                    guard let data = data else {return}
                    
                    let decoder = JSONDecoder()
                    let networkModels = try? decoder.decode([GithubOrganizationNetwork].self, from: data)
                    
                    let result: [GithubOrganization]? = networkModels?.map {
                        let data: Data?
                        
                        if let avatar = $0.avatarUrl, let url = URL(string: avatar) {
                            data = try? Data(contentsOf: url)
                        } else {
                            data = nil
                        }
                        
                        return GithubOrganization(login: $0.login, avatar: data)
                    }
                    
                    DispatchQueue.main.async {
                        completion(result ?? [])
                    }
                } else {
                    guard let data = data else { return }
                    print("Error:" + String(httpResponse.statusCode))
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
        }
        
        task.resume()
    }
}

struct GithubOrganizationNetwork: Codable {
    let login: String
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}

struct GithubOrganization: Codable {
    public let login: String
    public let avatar: Data?
    
    init(login: String, avatar: Data?) {
        self.login = login
        self.avatar = avatar
    }
}
