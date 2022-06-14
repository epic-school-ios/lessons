//
//  OrganizationCache.swift
//  sometestapp
//
//  Created by Yuriy on 12.04.2022.
//

import Foundation

class InmemoryOrganizationCache: DataProvider {
    private var data: [GithubOrganization] = []
    
    func fetchData(completion: @escaping ([GithubOrganization]) -> Void) {
        print("Githubapi cache")
        
        completion(data)
    }
    
    func saveData(organizations: [GithubOrganization]) {
        data = organizations
    }
}
