//
//  Entity+CoreDataProperties.swift
//  sometestapp
//
//  Created by Yuriy on 14.04.2022.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var login: String?
    @NSManaged public var avatar: Data?

}

extension Entity : Identifiable {

}
