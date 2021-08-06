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
    
    private lazy var startCookButton: StartCookButton = {
        let startCookButton = StartCookButton()
        startCookButton.addTarget(self, action: #selector(startCookButtonTapped), for: .touchUpInside)
        return startCookButton
    }()
    
    private lazy var timerButton: TimerButton = {
        let timerButton = TimerButton()
        timerButton.addTarget(self, action: #selector(setTimerButtonTapped), for: .touchUpInside)
        return timerButton
    }()
    
    private lazy var collectionView: InstructionCollectionView = {
        let collectionView = InstructionCollectionView(width: view.bounds.width)
        return collectionView
    }()
    

    
 
    
    //MARK: Dependences
    
    var viewModel: ProductInfoViewModelProtocol
    
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
        setupCollectionView() // временно
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
        setupStartCookButtonConstraints()
        setupTimerButtonConstraints()
        setupCollectionViewConstraints()
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
            productNameLabel.topAnchor.constraint(equalTo: plateImageView.bottomAnchor, constant: 6)])
    }
    private func setupProductViewConstraints() {
        viewWithContent.addSubview(productView)
        NSLayoutConstraint.activate([
            productView.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor, constant: 15),
            productView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor, constant: -15),
            productView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1/4)
        ])
    }
    
    private func setupStartCookButtonConstraints() {
        viewWithContent.addSubview(startCookButton)
        NSLayoutConstraint.activate([
            startCookButton.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1/12),
            startCookButton.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor),
            startCookButton.topAnchor.constraint(equalTo: productView.bottomAnchor, constant: 35),
            startCookButton.widthAnchor.constraint(equalTo: viewWithContent.widthAnchor, multiplier: 2/3)
        ])
    }
    
    private func setupTimerButtonConstraints() {
        viewWithContent.addSubview(timerButton)
        NSLayoutConstraint.activate([
            timerButton.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1/12),
            timerButton.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor),
            timerButton.bottomAnchor.constraint(equalTo: startCookButton.topAnchor, constant: -15),
            timerButton.widthAnchor.constraint(equalTo: viewWithContent.widthAnchor, multiplier: 2/3)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        viewWithContent.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: 15),
//            collectionView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1/3)
            collectionView.bottomAnchor.constraint(equalTo: timerButton.topAnchor, constant: -35)
        ])
    }
    
  
    

    
        
    
    
    //MARK: Animations
    
    private func disappearAnimations() {
        disappearPlateAnimation()
        disappearContentViewAnimation()
        disappearProductViewAnimation()
        disappearStartCookButtonAnimation()
        disappearCollectionViewAnimation()
        disappearTimerButtonAnimation()
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
            withDuration: 0.5, delay: 0.8, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
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
    
    private func appearStartCookButtonAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.startCookButton.transform = .identity
                self.startCookButton.alpha = 1
        }, completion: nil)
    }
    
    private func disappearStartCookButtonAnimation() {
        self.startCookButton.alpha = 0
        self.startCookButton.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }
    
    
    private func appearCollectionViewAnimation() {
        collectionView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 1
        }
    }
    
    private func disappearCollectionViewAnimation() {
        collectionView.alpha = 0
    }
    
    
    private func collectionViewLayoutAnimation(velocity: CGPoint, point: CGPoint ) {
        UIView.animate(withDuration: 0.3, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: velocity.x,
                       options: .allowUserInteraction, animations: {
            self.collectionView.setContentOffset(point, animated: true)
        }, completion: nil)
    }
    
    private func appearTimerButtonAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.timerButton.transform = .identity
                self.timerButton.alpha = 1
        }, completion: nil)
    }
    
    private func disappearTimerButtonAnimation() {
        self.timerButton.alpha = 0
        self.timerButton.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }

    
    
    
    //MARK: Private Methodes
    
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
            self?.appearStartCookButtonAnimation()
            self?.startCookButton.startState()
            self?.disappearCollectionViewAnimation()
            self?.disappearTimerButtonAnimation()
        }
        
        viewModel.needUpdateViewForThirdStep = { [weak self] in
            self?.disappearPlateAnimation()
            self?.disappearProductViewAnimation()
            self?.startCookButton.stopState()
            self?.appearContentViewAnimation()
            self?.appearStartCookButtonAnimation()
            self?.appearCollectionViewAnimation()
            self?.appearTimerButtonAnimation()
            self?.viewModel.resetCollectionViewLayout()
            self?.collectionView.createLayout()
        }
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
    
    //CollectionView
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.createLayout()
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
    
    @objc private func startCookButtonTapped() {
        viewModel.buttonStartCookTapped.toggle()
        viewModel.checkCurrentStateAndUpdateView()
    }
    
    @objc private func setTimerButtonTapped() {
        let timerViewModel = viewModel.getTimerViewModel()
        let timerVC = TimerViewController(nibName: nil, bundle: nil, viewModel: timerViewModel)
        timerVC.modalPresentationStyle = .overCurrentContext
        
        Notifications.shared.checkNotificationSettings { [weak self] in
            let alert = Notifications.notificationsAreNotAvailableAlert()
            self?.present(alert, animated: true)
        }
        timerButton.layer.removeAllAnimations()
        present(timerVC, animated: true)
    }
}

//MARK: UICollectionViewDelegate

extension ProductInfoViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let point = viewModel.targetContentOffset(scrollView,
                                                  withVelocity: velocity,
                                                  collectionView: collectionView)
        targetContentOffset.pointee = point
        collectionViewLayoutAnimation(velocity: velocity, point: point)
    }
}

//MARK: UICollectionViewDataSource

extension ProductInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "instructionCell", for: indexPath) as? InstructionCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setViewModel(viewModel: viewModel.cellViewModel(at: indexPath))
        return cell
        
    }
    
    
}
