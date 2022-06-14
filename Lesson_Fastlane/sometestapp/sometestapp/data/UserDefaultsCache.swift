//
//  UserDefaultsCache.swift
//  sometestapp
//
//  Created by Yuriy on 12.04.2022.
//

import Foundation

class UserDefaultsCache: DataProvider {
    private static let key = "ogranizations"
    private let userDefauls = UserDefaults.standard
    
    func fetchData(completion: @escaping ([GithubOrganization]) -> Void) {
        print("Githubapi defaults cache")
        
        //userDefauls.set
        
        if let data = userDefauls.object(forKey: Self.key) as? Data {
            let decoder = JSONDecoder()
            let result = try? decoder.decode([GithubOrganization].self, from: data)
            
            completion(result ?? [])
            return
        }
        
        completion([])
    }
    
    func saveData(organizations: [GithubOrganization]) {
        print("Githubapi save defaults cache")
        let encoder = JSONEncoder()
        let result = try? encoder.encode(organizations)
        
        userDefauls.set(result, forKey: Self.key)
    }
    
    func clear() {
        print("Githubapi clear defaults cache")
        userDefauls.removeObject(forKey: Self.key)
    }
}
