//
//  RecentProductViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import Foundation
import CoreData

protocol RecentProductViewModelProtocol: AnyObject {
    func getRecentProductCollectionViewViewModel() -> RecentProductCollectionViewViewModelProtocol
    func checkCurrentState(isHidden: Bool) -> String
    func getMainContext() -> NSManagedObjectContext
    init(storageService: StorageServiceProtocol)
}

final class RecentProductViewModel: RecentProductViewModelProtocol {

    func getMainContext() -> NSManagedObjectContext {
        storageService.getMainContext()
    }

    private let storageService: StorageServiceProtocol

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func getRecentProductCollectionViewViewModel() -> RecentProductCollectionViewViewModelProtocol {
        RecentProductCollectionViewViewModel(storageService: storageService)
    }
    
    func checkCurrentState(isHidden: Bool) -> String {
        isHidden ? Inscriptions.recentProductTitle : Inscriptions.messageRecentProductNotFound
    }
}
