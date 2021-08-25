//
//  ItemCategory+CoreDataProperties.swift
//  Todoey
//
//  Created by Mohammed Al Busaidi on 24/08/2021.
//
//

import Foundation
import CoreData


extension ItemCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCategory> {
        return NSFetchRequest<ItemCategory>(entityName: "ItemCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension ItemCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension ItemCategory : Identifiable {

}
