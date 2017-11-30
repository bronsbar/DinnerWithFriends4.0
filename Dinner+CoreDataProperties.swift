//
//  Dinner+CoreDataProperties.swift
//  DinnerWithFriends4.0
//
//  Created by Bart Bronselaer on 30/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//
//

import Foundation
import CoreData


extension Dinner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dinner> {
        return NSFetchRequest<Dinner>(entityName: "Dinner")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var friends: NSObject?
    @NSManaged public var notes: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var rating: Int16
    @NSManaged public var dinnerItem: NSSet?

}

// MARK: Generated accessors for dinnerItem
extension Dinner {

    @objc(addDinnerItemObject:)
    @NSManaged public func addToDinnerItem(_ value: DinnerItem)

    @objc(removeDinnerItemObject:)
    @NSManaged public func removeFromDinnerItem(_ value: DinnerItem)

    @objc(addDinnerItem:)
    @NSManaged public func addToDinnerItem(_ values: NSSet)

    @objc(removeDinnerItem:)
    @NSManaged public func removeFromDinnerItem(_ values: NSSet)

}
