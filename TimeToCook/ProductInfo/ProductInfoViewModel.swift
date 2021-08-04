//
//  ProductInfoViewModel2.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 31.07.2021.
//

import UIKit

    protocol ProductInfoViewModelProtocol {
        var product: Product? { get }
        var weight: String { get }
        var cookingTime: String { get }
        var isHiddenProductStackView: Bool { get }
        var productImage: String { get }
//        func cellViewModel(at indexPath: IndexPath) -> ProductInfoCollectionViewCellViewModelProtocol?
        
        init(product: Product?)
        func getTimerViewModel() -> TimerViewModelProtocol
        
        
        var needUpdateViewForFirstStep: (() -> Void)? { get set }
        var needUpdateViewForSecondStep: (() -> Void)? { get set }
        var needUpdateViewForThirdStep: (() -> Void)? { get set }
        var buttonStartCookTapped: Bool { get set }
        func checkCurrentStateAndUpdateView()
        
        func updateProduct(product: Product?)
        
    }

    final class ProductInfoViewModel: ProductInfoViewModelProtocol {
        
        var needUpdateViewForFirstStep: (() -> Void)?
        var needUpdateViewForSecondStep: (() -> Void)?
        var needUpdateViewForThirdStep: (() -> Void)?
        var buttonStartCookTapped: Bool = false
        
        
        // MARK: - Properties
        
        var product: Product? = nil
        
        var productImage: String {
            let productImage = product?.category ?? ""
            return "\(productImage).png"
        }
        
        var weight: String {
            guard let weight = product?.weight else {
                return "Н/Д"
            }
            return "\(weight) г."
        }
        
        var cookingTime: String {
            let cookingTime = (product?.cookingTime ?? 0)
            return "\(cookingTime) мин."
        }
        
        var isHiddenProductStackView: Bool {
            return product == nil
        }
        
        
        
        // MARK: - Initializers
        
        init(product: Product? = nil) {
            self.product = product
        }
        
        // MARK: - Methods
        
//        func cellViewModel(at indexPath: IndexPath) -> ProductInfoCollectionViewCellViewModelProtocol? {
//            return ProductInfoCollectionViewCellViewModel(product: product.value, indexPath: indexPath)
//        }
        
        // MARK: - Public methods
        
        func getTimerViewModel() -> TimerViewModelProtocol {
            TimerViewModel(minutes: product?.cookingTime ?? 0)
        }
        
        
        func checkCurrentStateAndUpdateView() {
            if product == nil {
                needUpdateViewForFirstStep?()
            } else {
                buttonStartCookTapped
                    ? needUpdateViewForThirdStep?()
                    : needUpdateViewForSecondStep?()
            }
        }
        
        func updateProduct(product: Product?) {
            self.product = product
        }
    }


