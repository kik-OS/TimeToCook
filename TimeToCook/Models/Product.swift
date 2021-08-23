//
//  Product.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.06.2021.
//

import Firebase

protocol ProductProtocol {
    var code: String { get }
    var title: String { get }
    var producer: String { get }
    var category: String { get }
    var weight: Int? { get }
    var cookingTime: Int { get }
    var intoBoilingWater: Bool? { get }
    var needStirring: Bool? { get }
    var waterRatio: Double { get }
    func convertToDictionary() -> Any
}

struct Product: ProductProtocol {
    
    // MARK: - Properties
    
    let code: String
    let title: String
    let producer: String
    let category: String
    let weight: Int?
    let cookingTime: Int
    let intoBoilingWater: Bool?
    let needStirring: Bool?
    let waterRatio: Double
    let ref: DatabaseReference?
    
    // MARK: - Initializers
    
    init(code: String, title: String, producer: String,
         category: String, weight: Int?,
         cookingTime: Int, intoBoilingWater: Bool?,
         needStirring: Bool?, waterRatio: Double,
         ref: DatabaseReference? = nil) {
        
        self.code = code
        self.title = title
        self.producer = producer
        self.category = category
        self.weight = weight
        self.cookingTime = cookingTime
        self.intoBoilingWater = intoBoilingWater
        self.needStirring = needStirring
        self.waterRatio = waterRatio
        self.ref = ref
    }
    
    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: AnyObject],
              let code = snapshotValue["code"] as? String,
              let title = snapshotValue["title"] as? String,
              let producer = snapshotValue["producer"] as? String,
              let category = snapshotValue["category"] as? String,
              let cookingTime = snapshotValue["cookingTime"] as? Int,
              let waterRatio = snapshotValue["waterRatio"] as? Double
              else { return nil }
        
        self.code = code
        self.title = title
        self.producer = producer
        self.category = category
        self.weight = snapshotValue["weight"] as? Int
        self.cookingTime = cookingTime
        self.intoBoilingWater = snapshotValue["intoBoilingWater"] as? Bool
        self.needStirring = snapshotValue["needStirring"] as? Bool
        self.waterRatio = waterRatio
        self.ref = snapshot.ref
    }
    
    // MARK: - Public methods
    
    func convertToDictionary() -> Any {
        ["code": code,
         "title": title,
         "producer": producer,
         "category": category,
         "weight": weight as Any,
         "cookingTime": cookingTime,
         "intoBoilingWater": intoBoilingWater as Any,
         "needStirring": needStirring as Any,
         "waterRatio": waterRatio,
         "ref": ref as Any]
    }
}
