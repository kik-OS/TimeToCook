//
//  ProductInfoViewController.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 22.07.2021.
//

import UIKit

final class ProductInfoViewController: UIViewController {
    
    //MARK: UI
    
    private lazy var viewWithContent: ViewWithContent = {
        let viewWithContent = ViewWithContent()
        return viewWithContent
    }()
    
    private lazy var plateImageView: PlateImageView = {
        let plateImageView = PlateImageView()
        return plateImageView
    }()
    
    private lazy var stillEmpty: StillEmptyView = {
        let stillEmpty = StillEmptyView()
        return stillEmpty
    }()
    
    private lazy var productView: ProductView = {
        let productView = ProductView()
        return productView
    }()
    
    private lazy var productNameLabel: ProductNameLabel = {
        let productNameLabel = ProductNameLabel()
        return productNameLabel
    }()
    
    //MARK: Dependences
    
    var viewModel: ProductInfoViewModelProtocol {
        didSet {
            setupViewModelBindings()
        }
    }
    
    //MARK: Init
    
    init(viewModel: ProductInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    private var plateImageViewLeadingConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addVerticalGradientLayer()
        setupAllConstraints()
        setupViewModelBindingsForAnimation()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.checkCurrentStateAndUpdateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disappearAnimations()
    }
    
    //MARK: AutoLayout
    
    private func setupAllConstraints() {
        setupViewWithContentConstraints()
        setupPlateImageViewConstraints()
        setupStillEmptyViewConstraints()
        setupProductNameLabelConstraints()
        setupProductViewConstraints()
    }
    
    private func setupViewWithContentConstraints() {
        view.addSubview(viewWithContent)
        contentViewBottomConstraint = viewWithContent.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                              constant: view.frame.height * 2/3)
        contentViewBottomConstraint?.isActive = true
        NSLayoutConstraint.activate([
             viewWithContent.widthAnchor.constraint(equalTo: view.widthAnchor),
             viewWithContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3)])
    }
    
    private func setupPlateImageViewConstraints() {
        view.addSubview(plateImageView)
        plateImageViewLeadingConstraint = plateImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor)
        plateImageViewLeadingConstraint?.isActive = true
        NSLayoutConstraint.activate([
             plateImageView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 0.56),
             plateImageView.widthAnchor.constraint(equalTo: plateImageView.heightAnchor),
             plateImageView.centerYAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: -20)])
    }
    
    private func setupStillEmptyViewConstraints() {
        viewWithContent.addSubview(stillEmpty)
        NSLayoutConstraint.activate([
            stillEmpty.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor, constant: 15),
            stillEmpty.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor,constant: -15),
            stillEmpty.topAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: 15),
            stillEmpty.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 2/3)])
    }
    
    private func setupProductNameLabelConstraints() {
        viewWithContent.addSubview(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor, constant: 15),
            productNameLabel.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor, constant: -15),
            productNameLabel.topAnchor.constraint(equalTo: plateImageView.bottomAnchor, constant: 15)])
    }
    private func setupProductViewConstraints() {
        viewWithContent.addSubview(productView)
        NSLayoutConstraint.activate([
            productView.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor, constant: 15),
            productView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor, constant: -15),
            productView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1/4)])
    }
    
        
    
    
    //MARK: Animations
    
    private func disappearAnimations() {
        disappearPlateAnimation()
        disappearContentViewAnimation()
        disappearProductViewAnimation()
    }
    
    private func appearPlateAnimation() {
        plateImageView.alpha = 1
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 2,
                       initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.plateImageViewLeadingConstraint?.constant = -self.plateImageView.frame.width * 0.8
                        self.view.layoutIfNeeded() })
        
        UIView.animate(withDuration: 0.3,
            animations: { self.plateImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) },
            completion: { _ in UIView.animate(withDuration: 0.4) {
                    self.plateImageView.transform = CGAffineTransform.identity }})
        }
    
    
    private func disappearPlateAnimation() {
        UIView.animate(withDuration: 0.1) {
            self.plateImageView.alpha = 0
            self.plateImageViewLeadingConstraint?.constant = 0
            self.view.layoutIfNeeded() }
    }
    
    private func appearContentViewAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2,
                       initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.contentViewBottomConstraint?.constant = 0
                        self.view.layoutIfNeeded() })
    }
    
    private func disappearContentViewAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.contentViewBottomConstraint?.constant = self.view.frame.height * 2/3
            self.view.layoutIfNeeded() }
    }
    
    private func appearProductViewAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.productNameLabel.transform = .identity
                self.productNameLabel.alpha = 1
                self.productView.transform = .identity
                self.productView.alpha = 1
        }, completion: nil)
    }
    
    private func disappearProductViewAnimation() {
        self.productView.alpha = 0
        self.productView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        self.productNameLabel.alpha = 0
        self.productNameLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    
    
    //MARK: Private Methodes
    
    private func  setupViewModelBindings() {

    }
    
    private func setupViewModelBindingsForAnimation() {
        viewModel.needUpdateViewForFirstStep = { [weak self] in
            
            self?.appearContentViewAnimation()
        }
        
        viewModel.needUpdateViewForSecondStep = { [weak self] in
            self?.stillEmpty.alpha = 0
            self?.appearContentViewAnimation()
            self?.appearPlateAnimation()
            self?.updateProductInfo()
            self?.appearProductViewAnimation()
        }
        
//        viewModel.needUpdateViewForThirdStep = { [weak self] in
//
//        }
    }
    
    private func updateProductInfo() {
        plateImageView.image = UIImage(named: viewModel.productImage)
        productView.setBarcode(barcode: viewModel.product?.code ?? "")
        productView.setCategory(category: viewModel.product?.category ?? "")
        productView.setWeight(weight: viewModel.weight)
        productView.setProducer(producer: viewModel.product?.producer ?? "")
        productView.setTime(time: viewModel.cookingTime)
        productNameLabel.setName(name: viewModel.product?.title ?? "")
    }
    
    //Gradient
    private func addVerticalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor, #colorLiteral(red: 0.8979474902, green: 0.9020553231, blue: 0.8977640867, alpha: 1).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    //NavigationBar
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}


