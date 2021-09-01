//
//  CustomTabBarController.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import UIKit

protocol AddNewProductViewControllerDelegate: AnyObject {
    func productWasAdded(product: Product?)
}

protocol BarcodeScannerViewControllerDelegate: AnyObject {
    func scanner(barcode: String)
}

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    // MARK: UI

    private lazy var middleButton: TabBarMiddleButton = {
        let middleButton = TabBarMiddleButton()
        return middleButton
    }()
    
    // MARK: - Dependences
    
    var viewModel: TabBarViewModelProtocol

    // MARK: - Initializers
    
    init(viewModel: TabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        loadTabBar()
        setupMiddleButton()
        setupTabBarItems()
        setupViewModelBindings()
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = UIScreen.main.bounds.width / 2.5
        middleButton.layer.cornerRadius = middleButton.frame.width / 2
    }
    
    // MARK: - Actions

    private func loadTabBar() {
        let tabBar = viewModel.createCustomTabBar()
        self.setValue(tabBar, forKey: "tabBar")
    }
    
    private func setupNavigationBar() {
        let image = UIImage(systemName: "timer")
        let timerButton = UIBarButtonItem(image: image,
                                          style: .plain,
                                          target: self,
                                          action: #selector(timerBarButtonTapped))
        timerButton.accessibilityLabel = "timerNavButton"
        timerButton.tintColor = .systemGray
        navigationItem.rightBarButtonItems = [timerButton]
    }
    
    @objc private func centerButtonAction(sender: UIButton) {
        sender.animationForMiddleButton()
        let barCodeScannerVC = BarcodeScannerViewController()
        barCodeScannerVC.delegate = self
        barCodeScannerVC.modalPresentationStyle = .fullScreen
        present(barCodeScannerVC, animated: true, completion: nil)
    }
    
    @objc private func timerBarButtonTapped(_ sender: UIBarButtonItem) {
        let timerViewModel = viewModel.getTimerViewModel()
        let timerVC = TimerViewController(viewModel: timerViewModel)
        timerVC.modalPresentationStyle = .overCurrentContext
        present(timerVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupTabBarItems() {
        tabBar.tintColor = VarkaColors.mainColor
        
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
            middleButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor,
                                                  constant: CGFloat(viewModel.constantForMiddleButton)),
            middleButton.widthAnchor.constraint(equalToConstant: CGFloat(viewModel.sizeForMiddleButton)),
            middleButton.heightAnchor.constraint(equalToConstant: CGFloat(viewModel.sizeForMiddleButton))])
    }
    
    private func setupViewModelBindings() {
        viewModel.productDidReceive = { [unowned self] product in
            guard let productInfoVC = viewControllers?.first as? ProductInfoViewController else { return }
            productInfoVC.viewModel.updateProduct(product: product)
            selectedViewController = viewControllers?.first
        }
        
        viewModel.addingNewProductOffer = { [unowned self] code in
            let alertController = offerToAddingProductAlertController {
                let addingNewProductViewModel = self.viewModel.getAddingNewProductViewModel(withCode: code)
                let addNewProductVC = AddingNewProductViewController(viewModel: addingNewProductViewModel)
                addNewProductVC.delegate = self
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
    
    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarTransition(viewControllers: tabBarController.viewControllers)
    }
}

// MARK: - Extensions

extension TabBarViewController: BarcodeScannerViewControllerDelegate {
    func scanner(barcode: String) {
        viewModel.findProduct(byCode: barcode)
    }
}

extension TabBarViewController: AddNewProductViewControllerDelegate {
    func productWasAdded(product: Product?) {
        guard let productInfoVC = viewControllers?.first as? ProductInfoViewController else { return }
        productInfoVC.viewModel.updateProduct(product: product)
        selectedViewController = viewControllers?.first
    }
}
