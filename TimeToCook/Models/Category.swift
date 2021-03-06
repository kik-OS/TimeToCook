//
//  Category.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.06.2021.
//

import Firebase

struct Category {

    // MARK: - Class properties

    static private var idIterator = 0

    // MARK: - Class methods

    static private func getID() -> Int {
        idIterator += 1
        return idIterator
    }

    // MARK: - Properties

    let identifier: Int
    let name: String
    let imageName: String
    let date: Date

    // MARK: - Initializers

    init(name: String) {
        self.identifier = Category.getID()
        self.name = name
        self.imageName = name
        self.date = Date()
    }

    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: AnyObject],
              let stringDate = snapshotValue["date"] as? String else { return nil }

        identifier = snapshotValue["id"] as? Int ?? Int()
        name = snapshotValue["name"] as? String ?? String()
        imageName = snapshotValue["imageName"] as? String ?? String()
        date = DateFormatter.firebaseDateFormatter.date(from: stringDate) ?? Date()
    }

    // MARK: - Public methods

    func convertToDictionary() -> Any {
        ["id": identifier,
         "name": name,
         "imageName": imageName,
         "date": DateFormatter.firebaseDateFormatter.string(from: date)]
    }
}
