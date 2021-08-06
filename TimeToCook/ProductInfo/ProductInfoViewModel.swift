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
    var needUpdateViewForFirstStep: (() -> Void)? { get set }
    var needUpdateViewForSecondStep: (() -> Void)? { get set }
    var needUpdateViewForThirdStep: (() -> Void)? { get set }
    var buttonStartCookTapped: Bool { get set }
    var previousOffset: CGFloat {get set}
    var currentPage: Int {get set}
    init(product: Product?)
    
    func getTimerViewModel() -> TimerViewModelProtocol
    func checkCurrentStateAndUpdateView()
    func updateProduct(product: Product?)
    func targetContentOffset(_ scrollView: UIScrollView,
                             withVelocity velocity: CGPoint,
                             collectionView: UICollectionView) -> CGPoint
    func cellViewModel(at indexPath: IndexPath) -> InstructionCollectionViewCellViewModelProtocol?
    func resetCollectionViewLayout()
}

final class ProductInfoViewModel: ProductInfoViewModelProtocol {
    
    // MARK: - Properties
    
    var needUpdateViewForFirstStep: (() -> Void)?
    var needUpdateViewForSecondStep: (() -> Void)?
    var needUpdateViewForThirdStep: (() -> Void)?
    var buttonStartCookTapped: Bool = false
    var previousOffset: CGFloat = 0
    var currentPage: Int = 0
    
    var product: Product? = nil {
        didSet {
            buttonStartCookTapped = false
        }
    }
    
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
    
    
    // MARK: - Init
    
    init(product: Product? = nil) {
        self.product = product
    }
    
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
    
    func targetContentOffset(_ scrollView: UIScrollView,
                             withVelocity velocity: CGPoint,
                             collectionView: UICollectionView) -> CGPoint {
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage -= 1
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage += 1
        }
        
        let additional = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) - flowLayout.headerReferenceSize.width
        let updatedOffset = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) * CGFloat(currentPage) - additional
        previousOffset = updatedOffset
        
        return CGPoint(x: updatedOffset, y: 0)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> InstructionCollectionViewCellViewModelProtocol? {
        return InstructionCollectionViewCellViewModel(product: product, indexPath: indexPath)
    }
    
    func resetCollectionViewLayout() {
        currentPage = 0
        previousOffset = 0
    }
}


