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
}

final class RecentProductViewModel: RecentProductViewModelProtocol {
    
    func getRecentProductCollectionViewViewModel() -> RecentProductCollectionViewViewModelProtocol {
        RecentProductCollectionViewViewModel()
    }
    
    func checkCurrentState(isHidden: Bool) -> String {
        isHidden ? Inscriptions.recentProductTitle : Inscriptions.messageRecentProductNotFound
    }
}
