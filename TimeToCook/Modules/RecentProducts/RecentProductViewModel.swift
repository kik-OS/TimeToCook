//
//  RecentProductViewModel.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 05.03.2021.
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
        isHidden ? "Недавние Продукты" : "В недавних продуктах ничего не найдено. Попробуйте что-нибудь отсканировать."
    }

    
}
