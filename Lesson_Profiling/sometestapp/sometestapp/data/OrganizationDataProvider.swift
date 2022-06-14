//
//  OrganizationDataProvider.swift
//  sometestapp
//
//  Created by Yuriy on 12.04.2022.
//

import Foundation

class OrganizationDataProvider: DataProvider {
    private let cache = UserDefaultsCache()
    private let network = GithubApi()
    
    func fetchData(completion: @escaping ([GithubOrganization]) -> Void) {
        // получаем данные из кеша
        cache.fetchData { cached in
            // если кеш пустой
            if cached.isEmpty {
                // запрашиваем из сети
                self.network.fetchData { fromNetwork in
                    // сохраняю в кеш
                    self.cache.saveData(organizations: fromNetwork)
                    // отдали
                    completion(fromNetwork)
                }
            } else {
                completion(cached)
            }
        }
    }
    
    func saveData(organizations: [GithubOrganization]) {
        
    }
    
    func clear() {
        cache.clear()
    }
}
