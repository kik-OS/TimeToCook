//
//  CustomTabBarController.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 05.03.2021.
//

import UIKit
//import BarcodeScanner

protocol BarcodeScannerViewControllerDelegate {
    func scanner(barcode: String)
}

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    
    // MARK: - Properties
    
    var viewModel: CustomTabBarViewModelProtocol
    private let middleButton = UIButton.setupMiddleButtonTabBar()
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        viewModel = CustomTabBarViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
        setupTabBarItems()
        setupViewModelBindings()
        delegate = self
    
        
//
        StorageManager.shared.saveProductCD(product: Product(code: "21121909098", title: "Макароны", producer: "Макфа", category: "Макароны", weight: 20, cookingTime: 10, intoBoilingWater: true, needStirring: true, waterRatio: 3))
        StorageManager.shared.saveProductCD(product: Product(code: "3332156464", title: "Вареники с вишней", producer: "ВкусВилл", category: "Вареники", weight: 1000, cookingTime: 7, intoBoilingWater: true, needStirring: true, waterRatio: 5))
        StorageManager.shared.saveProductCD(product: Product(code: "21121453543", title: "Гречка Русская", producer: "Макфа", category: "Гречка", weight: 500, cookingTime: 20, intoBoilingWater: true, needStirring: true, waterRatio: 3))
        StorageManager.shared.saveProductCD(product: Product(code: "333219090", title: "Нут", producer: "Макфа", category: "Бобовые", weight: 200, cookingTime: 40, intoBoilingWater: true, needStirring: true, waterRatio: 3))
        StorageManager.shared.saveProductCD(product: Product(code: "938040340", title: "Пельмени-Экстра", producer: "Мираторг", category: "Пельмени", weight: 1000, cookingTime: 8, intoBoilingWater: true, needStirring: true, waterRatio: 3))
        StorageManager.shared.saveProductCD(product: Product(code: "943560000", title: "Пшено", producer: "Увелка", category: "Каши", weight: 500, cookingTime: 3, intoBoilingWater: true, needStirring: true, waterRatio: 3))
        StorageManager.shared.saveProductCD(product: Product(code: "94356000043", title: "Пшено еще пшено опять пшено вкусное пшено", producer: "Увелка4к34к34кцуауцауцауцацу", category: "Каши", weight: 500, cookingTime: 3, intoBoilingWater: true, needStirring: true, waterRatio: 3))
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = UIScreen.main.bounds.width / 2.5
        middleButton.layer.cornerRadius = middleButton.frame.width / 2
    }
    
    
    // MARK: - Actions
    
    @objc private func centerButtonAction(sender: UIButton) {
        sender.animationForMiddleButton()

        
        let barCodeScannerVC = BarcodeScannerViewController()
        barCodeScannerVC.delegate = self
        barCodeScannerVC.modalPresentationStyle = .fullScreen
        present(barCodeScannerVC, animated: true, completion: nil)
        
    }
    
    @IBAction private func timerBarButtonTapped(_ sender: UIBarButtonItem) {
        let timerViewModel = viewModel.getTimerViewModel()
        let timerVC = TimerViewController(nibName: nil, bundle: nil, viewModel: timerViewModel)
        timerVC.modalPresentationStyle = .overCurrentContext
        present(timerVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupTabBarItems() {
        tabBar.tintColor = VarkaColors.mainColor
//        let productInfoViewModel = viewModel.getProductInfoViewModel(product: nil)
//        let productInfoVC = ProductInfoViewController(nibName: nil,
//                                                      bundle: nil,
//                                                      viewModel: productInfoViewModel)
//        productInfoVC.tabBarItem.title = Inscriptions.tabBarItemLeftTitle
//        productInfoVC.tabBarItem.image = UIImage(named: ImageTitles.tabBarItemLeft)
        let recentProductsVC = RecentProductsViewController()
        recentProductsVC.viewModel = viewModel.getRecentProductViewModel()
        recentProductsVC.tabBarItem.title = Inscriptions.tabBarItemRightTitle
        recentProductsVC.tabBarItem.image = UIImage(named: ImageTitles.tabBarItemRight)
        
        let productInfoViewModel2 = viewModel.getProductInfoViewModel(product: nil)
        let newVC = ProductInfoViewController(viewModel: productInfoViewModel2)
        newVC.tabBarItem.title = Inscriptions.tabBarItemLeftTitle
        newVC.tabBarItem.image = UIImage(named: ImageTitles.tabBarItemLeft)
        viewControllers = [newVC, recentProductsVC]
    }
    
    private func setupMiddleButton() {
        middleButton.addTarget(self, action: #selector(centerButtonAction), for: .touchUpInside)
        view.addSubview(middleButton)
        view.layoutIfNeeded()
        NSLayoutConstraint.activate([
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: CGFloat(viewModel.constantForMiddleButton)),
            middleButton.widthAnchor.constraint(equalToConstant: CGFloat(viewModel.sizeForMiddleButton)),
            middleButton.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.sizeForMiddleButton))
        ])
    }
    
    private func setupViewModelBindings() {
        viewModel.productDidReceive = { [unowned self] product in
            guard let productInfoVC = viewControllers?.first as? ProductInfoViewController else { return }
            productInfoVC.viewModel.updateProduct(product: product)
            selectedViewController = viewControllers?.first
        }
        
        viewModel.addingNewProductOffer = { [unowned self] code in
            let alertController = offerToAddingProductAlertController {
                guard let addNewProductVC = self.storyboard?.instantiateViewController(
                    identifier: Inscriptions.addNewProductVCStoryBoardID
                ) as? AddingNewProductViewController else { return }
                addNewProductVC.viewModel = self.viewModel.getAddingNewProductViewModel(withCode: code)
                addNewProductVC.modalPresentationStyle = .fullScreen
                self.present(addNewProductVC, animated: true)
            }
            self.present(alertController, animated: true)
        }
        viewModel.timerDidStep = { [unowned self] time in
            title = time
        }
    }
    
    private func offerToAddingProductAlertController(okActionCompletion: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: Inscriptions.barCodeAlertTitle,
                                                message: Inscriptions.barCodeAlertMessage,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: Inscriptions.barCodeAlertButtonOkTitle,
                                     style: .default) { _ in okActionCompletion() }
        let cancelAction = UIAlertAction(title: Inscriptions.barCodeAlertButtonCancelTitle,
                                         style: .destructive) { _ in }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        return alertController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarTransition(viewControllers: tabBarController.viewControllers)
    }
}

// MARK: - Extensions

extension CustomTabBarController: BarcodeScannerViewControllerDelegate {
    func scanner(barcode: String) {
        viewModel.findProduct(byCode: barcode)
    }
}
