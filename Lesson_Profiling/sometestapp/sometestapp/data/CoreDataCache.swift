//
//  CoreDataCache.swift
//  sometestapp
//
//  Created by Yuriy on 14.04.2022.
//

import CoreData

class CoreDataCache: DataProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Github")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        // контекст главной очереди
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData(completion: @escaping ([GithubOrganization]) -> Void) {
        print("Githubapi core data")
        
        persistentContainer.viewContext.perform {
            let fetchRequest = Entity.fetchRequest()
            
            do {
                let result: [GithubOrganization] = try fetchRequest.execute().map {
                    GithubOrganization(login: $0.login ?? "", avatar: $0.avatar)
                }
                
                completion(result)
            } catch let error {
                print("Githubapi \(error)")
                completion([])
            }
        }
    }
    
    func saveData(organizations: [GithubOrganization]) {
        let context = persistentContainer.viewContext
        
        for organization in organizations {
            let coreDateOrg = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context) as? Entity
            coreDateOrg?.login = organization.login
            coreDateOrg?.avatar = organization.avatar
        }
        
        do {
            try context.save()
        } catch let error {
            print("Githubapi \(error)")
        }
    }
    
    func clear() {
        print("Githubapi clear")
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print("Githubapi \(error)")
        }
    }
}
