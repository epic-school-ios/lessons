//
//  DataProvider.swift
//  sometestapp
//
//  Created by Yuriy on 12.04.2022.
//

import Foundation

protocol DataProvider {
    func fetchData(completion: @escaping ([GithubOrganization]) -> Void)
    
    func saveData(organizations: [GithubOrganization])
    
    func clear()
}


extension DataProvider {
    func clear() {}
}
