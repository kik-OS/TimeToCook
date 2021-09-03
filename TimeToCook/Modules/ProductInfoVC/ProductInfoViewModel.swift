//
//  ProductInfoViewModel2.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 31.07.2021.
//

import UIKit

// MARK: - Protocol

protocol ProductInfoViewModelProtocol: AnyObject {
    var product: ProductProtocol? { get }
    var weight: String { get }
    var cookingTime: String { get }
    var isHiddenProductStackView: Bool { get }
    var productImage: String { get }
    var needUpdateViewForFirstStep: (() -> Void)? { get set }
    var needUpdateViewForSecondStep: (() -> Void)? { get set }
    var needUpdateViewForThirdStep: (() -> Void)? { get set }
    var buttonStartCookTapped: Bool { get set }
    var previousOffset: CGFloat { get set }
    var currentPage: Int { get set }
    var getNotificationService: NotificationServiceProtocol { get }

    init(product: ProductProtocol?,
         timerService: TimerServiceProtocol,
         notificationService: NotificationServiceProtocol)

    func getTimerViewController() -> TimerViewController
    func getAlertForNotification() -> UIAlertController
    func checkCurrentStateAndUpdateView()
    func updateProduct(product: ProductProtocol?)
    func cellViewModel(at indexPath: IndexPath) -> InstructionCollectionViewCellViewModelProtocol?
    func resetCollectionViewLayout()
    func targetContentOffset(_ scrollView: UIScrollView,
                             withVelocity velocity: CGPoint,
                             collectionView: UICollectionView) -> CGPoint
}

final class ProductInfoViewModel: ProductInfoViewModelProtocol {

    // MARK: - Services

    private let timerService: TimerServiceProtocol
    private let notificationService: NotificationServiceProtocol

    // MARK: - Properties

    var needUpdateViewForFirstStep: (() -> Void)?
    var needUpdateViewForSecondStep: (() -> Void)?
    var needUpdateViewForThirdStep: (() -> Void)?
    var buttonStartCookTapped = false
    var previousOffset: CGFloat = 0
    var currentPage = 0

    var product: ProductProtocol? {
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
        product == nil
    }

    var getNotificationService: NotificationServiceProtocol {
        notificationService
    }

    // MARK: - Init
    
    init(product: ProductProtocol? = nil,
         timerService: TimerServiceProtocol,
         notificationService: NotificationServiceProtocol) {
        self.timerService = timerService
        self.notificationService = notificationService
        self.product = product
    }
    
    // MARK: - Public methods

    func getTimerViewController() -> TimerViewController {
        let viewModel = TimerViewModel(timerService: timerService,
                                       notificationService: notificationService,
                                       minutes: product?.cookingTime ?? 0)
        return TimerViewController(viewModel: viewModel)
    }

    func getAlertForNotification() -> UIAlertController {
        notificationService.notificationsAreNotAvailableAlert()
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
    
    func updateProduct(product: ProductProtocol?) {
        self.product = product
    }
    
    func targetContentOffset(_ scrollView: UIScrollView,
                             withVelocity velocity: CGPoint,
                             collectionView: UICollectionView) -> CGPoint {
        
        guard let flowLayout = collectionView.collectionViewLayout
                as? UICollectionViewFlowLayout else { return .zero }
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage -= 1
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage += 1
        }
        
        let additional = (flowLayout.itemSize.width
                            + flowLayout.minimumLineSpacing)
            - flowLayout.headerReferenceSize.width
        let updatedOffset = (flowLayout.itemSize.width
                                + flowLayout.minimumLineSpacing)
            * CGFloat(currentPage)
            - additional
        previousOffset = updatedOffset
        return CGPoint(x: updatedOffset, y: 0)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> InstructionCollectionViewCellViewModelProtocol? {
        InstructionCollectionViewCellViewModel(product: product, indexPath: indexPath)
    }
    
    func resetCollectionViewLayout() {
        currentPage = 0
        previousOffset = 0
    }
}
