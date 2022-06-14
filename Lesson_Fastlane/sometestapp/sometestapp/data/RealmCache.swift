//
//  RealmCache.swift
//  sometestapp
//
//  Created by Yuriy on 14.04.2022.
//

//import Foundation
//import RealmSwift
//
//class RealmOrganization: Object {
//    @Persisted var login: String
//    @Persisted var avatar: Data?
//}
//
//class RealmCache: DataProvider {
//    // FIXME do not use try! in production!!!!
//    private let realm = try! Realm()
//
//    func fetchData(completion: @escaping ([GithubOrganization]) -> Void) {
//        print("Githubapi realm fetch")
//
//        let result: [GithubOrganization] = realm.objects(RealmOrganization.self).map {
//            GithubOrganization(login: $0.login, avatar: $0.avatar)
//        }
//
//        let objcs = realm.objects(RealmOrganization.self)
//        objcs.forEach { $0.login = "asdfasdf"}
//
//        completion(result)
//    }
//
//    func saveData(organizations: [GithubOrganization]) {
//        print("Githubapi realm save")
//
//        let realmObject: [RealmOrganization] = organizations.map {
//            let result = RealmOrganization()
//            result.login = $0.login
//            result.avatar = $0.avatar
//
//            return result
//        }
//
//        do {
//            try realm.write {
//                realm.add(realmObject)
//            }
//        } catch let error {
//            print("Githubapi realm \(error)")
//        }
//    }
//
//    func clear() {
//        print("Githubapi realm clear")
//        let allObjects = realm.objects(RealmOrganization.self)
//
//        do {
//            try realm.write {
//                realm.delete(allObjects)
//            }
//        } catch let error {
//            print("Githubapi realm \(error)")
//        }
//    }
//}
