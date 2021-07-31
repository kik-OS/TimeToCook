//
//  RecentProductViewModel.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 05.03.2021.
//

import Foundation

protocol RecentProductViewModelProtocol {
    func getProductInfoViewModel(product: Product?) -> ProductInfoViewModelProtocol2
    func getRecentProductCollectionViewViewModel() -> RecentProductCollectionViewViewModelProtocol
}

final class RecentProductViewModel: RecentProductViewModelProtocol {
    func getRecentProductCollectionViewViewModel() -> RecentProductCollectionViewViewModelProtocol {
        RecentProductCollectionViewViewModel()
    }
    
    func getProductInfoViewModel(product: Product?) -> ProductInfoViewModelProtocol2 {
        ProductInfoViewModel2(product: product)
    }
}
