//
//  RecentProductsViewController.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 05.03.2021.
//

import UIKit

protocol RecentProductCollectionViewDelegate {
    func presentInfoAboutProduct(product: Product)
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
        let recentProductCollectionView = RecentProductCollectionView()
        return recentProductCollectionView
    }()
    
    //MARK: Constraints
    
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
            recentProductLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)])
    }
    
    private func setupEmptyPlateImageConstraints() {
        view.addSubview(emptyPlateImage)
        NSLayoutConstraint.activate([
            emptyPlateImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyPlateImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            emptyPlateImage.topAnchor.constraint(equalTo: recentProductLabel.bottomAnchor, constant: 50),
            emptyPlateImage.heightAnchor.constraint(equalTo: emptyPlateImage.widthAnchor)])
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(recentProductCollectionView)
        NSLayoutConstraint.activate([
            recentProductCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recentProductCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentProductCollectionView.topAnchor.constraint(equalTo: recentProductLabel.bottomAnchor,
                                                             constant: 10),
            recentProductCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor,
                                                                constant: view.frame.height / 5)])
    }
    
    // MARK: - Dependences
    
    var viewModel: RecentProductViewModelProtocol!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentProductCollectionView.viewModel = viewModel.getRecentProductCollectionViewViewModel()
        recentProductCollectionView.viewModel.delegate = self
        addVerticalGradientLayer()
        setupAllConstraints()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentProductCollectionView.viewModel.fetchProductFromCoreData { [ weak self] in
            self?.recentProductCollectionView.reloadData()
            guard let isHidden = self?.recentProductCollectionView.viewModel.contentIsEmpty() else { return }
            self?.recentProductCollectionView.isHidden = isHidden
            self?.emptyPlateImage.isHidden = !isHidden
            self?.recentProductLabel.text = self?.viewModel.checkCurrentState(isHidden: !isHidden)
        }
    }
    
    // MARK: - Private methods
    
    private func addVerticalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor, #colorLiteral(red: 0.938239575, green: 0.938239575, blue: 0.938239575, alpha: 1).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}

extension RecentProductsViewController: RecentProductCollectionViewDelegate {
    func presentInfoAboutProduct(product: Product) {
        guard let productInfoVC = tabBarController?.viewControllers?.first as? ProductInfoViewController else { return }
        productInfoVC.viewModel.updateProduct(product: product)
        tabBarController?.selectedViewController = tabBarController?.viewControllers?.first
    }
}
