//
//  RecentProductViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import Foundation

protocol RecentProductViewModelProtocol {
    func getRecentProductCollectionViewViewModel() -> RecentProductCollectionViewViewModelProtocol
    func checkCurrentState(isHidden: Bool) -> String
    init(storageService: StorageServiceProtocol)
}

final class RecentProductViewModel: RecentProductViewModelProtocol {

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
