//
//  RecentProductsViewController.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import UIKit
import CoreData

protocol RecentProductCollectionViewDelegate: AnyObject {
    func presentInfoAboutProduct(product: ProductProtocol)
}

final class RecentProductsViewController: UIViewController {

    // MARK: UI
    
    private lazy var recentProductLabel: RecentProductLabel = {
        let recentProductLabel = RecentProductLabel()
        return recentProductLabel
    }()
    
    private lazy var emptyPlateImage: UIImageView = {
        let nothingFoundStack = UIImageView()
        nothingFoundStack.image = UIImage(named: "plate")
        nothingFoundStack.translatesAutoresizingMaskIntoConstraints = false
        nothingFoundStack.contentMode = .scaleAspectFit
        return nothingFoundStack
    }()
    
    private lazy var recentProductCollectionView: RecentProductCollectionView = {
        let viewModel = viewModel.getRecentProductCollectionViewViewModel()
        let recentProductCollectionView = RecentProductCollectionView(viewModel: viewModel)
        recentProductCollectionView.setDelegate(delegate: self)
        return recentProductCollectionView
    }()
    
    // MARK: - Dependences
    
    private var viewModel: RecentProductViewModelProtocol

    // MARK: - Init

    init(viewModel: RecentProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Constraints
    
    private func setupAllConstraints() {
        setupProductLabelConstraints()
        setupEmptyPlateImageConstraints()
        setupCollectionViewConstraints()
    }
    
    private func setupProductLabelConstraints() {
        view.addSubview(recentProductLabel)
        NSLayoutConstraint.activate([
            recentProductLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            recentProductLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            recentProductLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setupEmptyPlateImageConstraints() {
        view.addSubview(emptyPlateImage)
        NSLayoutConstraint.activate([
            emptyPlateImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyPlateImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2 / 3),
            emptyPlateImage.topAnchor.constraint(equalTo: recentProductLabel.bottomAnchor, constant: 50),
            emptyPlateImage.heightAnchor.constraint(equalTo: emptyPlateImage.widthAnchor)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(recentProductCollectionView)
        NSLayoutConstraint.activate([
            recentProductCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recentProductCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentProductCollectionView.topAnchor.constraint(equalTo: recentProductLabel.bottomAnchor,
                                                             constant: 10),
            recentProductCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor,
                                                                constant: view.frame.height / 5)
        ])
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer()
        setupAllConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentProductCollectionView.setContentOffset(CGPoint(x: -ConstantsCollectionView.leftDistanceToView,
                                                             y: -20), animated: false)
        recentProductCollectionView.getViewModel().fetchProductFromCoreData { [ weak self] in
//            self?.recentProductCollectionView.reloadData()
            guard let isHidden = self?.recentProductCollectionView.getViewModel().contentIsEmpty() else { return }
            self?.recentProductCollectionView.isHidden = false
            self?.emptyPlateImage.isHidden = !isHidden
            self?.recentProductLabel.text = self?.viewModel.checkCurrentState(isHidden: !isHidden)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recentProductCollectionView.setContentOffset(CGPoint(x: -ConstantsCollectionView.leftDistanceToView,
                                                             y: -20), animated: true)
    }
}

extension RecentProductsViewController: RecentProductCollectionViewDelegate {
    func presentInfoAboutProduct(product: ProductProtocol) {
        guard let productInfoVC = tabBarController?.viewControllers?.first as?
                ProductInfoViewController else { return }
        productInfoVC.viewModel.updateProduct(product: product)
        tabBarController?.selectedViewController = tabBarController?.viewControllers?.first
    }
}
