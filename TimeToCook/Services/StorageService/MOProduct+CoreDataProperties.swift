//
//  MOProduct+CoreDataProperties.swift
//  
//
//  Created by Никита Гвоздиков on 01.09.2021.
//
//

import Foundation
import CoreData


extension MOProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOProduct> {
        return NSFetchRequest<MOProduct>(entityName: "MOProduct")
    }

    @NSManaged public var code: String?
    @NSManaged public var category: String?
    @NSManaged public var cookingTime: Int64
    @NSManaged public var date: Date?
    @NSManaged public var intoBoilingWater: Bool
    @NSManaged public var needsStirring: Bool
    @NSManaged public var producer: String?
    @NSManaged public var title: String?
    @NSManaged public var waterRatio: Double
    @NSManaged public var weight: Int64

}
