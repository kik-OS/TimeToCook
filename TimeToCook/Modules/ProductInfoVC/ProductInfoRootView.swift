//
//  ProductInfoMainView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 16.09.2021.
//

import UIKit

final class ProductInfoRootView: UIView {

    // MARK: UI

    private lazy var viewWithContent: ViewWithContent = {
        let viewWithContent = ViewWithContent()
        return viewWithContent
    }()

    private lazy var plateImageView: PlateImageView = {
        let plateImageView = PlateImageView()
        return plateImageView
    }()

    private lazy var mascotImageView: MascotSecondImageView = {
        let mascotImageView = MascotSecondImageView()
        return mascotImageView
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
        let collectionView = InstructionCollectionView()
        return collectionView
    }()

    private lazy var pageControl: InstructionPageControl = {
        let pageControl = InstructionPageControl()
        pageControl.addTarget(self, action: #selector(pageControlSelectionAction(_:)), for: .valueChanged)
        return pageControl
    }()

    private lazy var closeButton: CloseButton = {
        let closeButton = CloseButton()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()

    // MARK: Properties

    private var plateImageViewLeadingConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?

    // MARK: CallBacks

    var startCookButtonCallBack: (() -> Void)?
    var setTimerButtonCallBack: (() -> Void)?
    var closeButtonCallBack: (() -> Void)?

    // MARK: Init

    init() {
        super.init(frame: .zero)
        addVerticalGradientLayer()
        setupAllConstraints()
    }

    override func layoutSubviews() {
       super.layoutSubviews()
        addVerticalGradientLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Autolayout

    private func setupAllConstraints() {
        setupViewWithContentConstraints()
        setupPlateImageViewConstraints()
        setupStillEmptyViewConstraints()
        setupProductNameLabelConstraints()
        setupProductViewConstraints()
        setupStartCookButtonConstraints()
        setupTimerButtonConstraints()
        setupCollectionViewConstraints()
        setupCloseButtonConstraints()
        setupMascotImageConstraints()
        setupPageControlConstraints()
    }

    private func setupViewWithContentConstraints() {
        addSubview(viewWithContent)
        contentViewBottomConstraint = viewWithContent.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                              constant: frame.height * 2 / 3)
        contentViewBottomConstraint?.isActive = true
        NSLayoutConstraint.activate([
            viewWithContent.widthAnchor.constraint(equalTo: widthAnchor),
            viewWithContent.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2 / 3)])
    }

    private func setupPlateImageViewConstraints() {
        addSubview(plateImageView)
        plateImageViewLeadingConstraint = plateImageView.leadingAnchor.constraint(equalTo: trailingAnchor)
        plateImageViewLeadingConstraint?.isActive = true
        NSLayoutConstraint.activate([
            plateImageView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 0.56),
            plateImageView.widthAnchor.constraint(equalTo: plateImageView.heightAnchor),
            plateImageView.centerYAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: -20)])
    }

    private func setupMascotImageConstraints() {
        addSubview(mascotImageView)
        NSLayoutConstraint.activate([
            mascotImageView.bottomAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: 10),
            mascotImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mascotImageView.heightAnchor.constraint(equalToConstant: 100)])
    }

    private func setupStillEmptyViewConstraints() {
        viewWithContent.addSubview(stillEmpty)
        NSLayoutConstraint.activate([
            stillEmpty.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor, constant: 15),
            stillEmpty.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor, constant: -15),
            stillEmpty.topAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: 30),
            stillEmpty.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 2 / 3)])
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
            productView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1 / 4)])
    }

    private func setupStartCookButtonConstraints() {
        viewWithContent.addSubview(startCookButton)
        NSLayoutConstraint.activate([
            startCookButton.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1 / 12),
            startCookButton.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor),
            startCookButton.topAnchor.constraint(equalTo: productView.bottomAnchor, constant: 35),
            startCookButton.widthAnchor.constraint(equalTo: viewWithContent.widthAnchor, multiplier: 2 / 3)])
    }

    private func setupTimerButtonConstraints() {
        viewWithContent.addSubview(timerButton)
        NSLayoutConstraint.activate([
            timerButton.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 1 / 12),
            timerButton.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor),
            timerButton.bottomAnchor.constraint(equalTo: startCookButton.topAnchor, constant: -15),
            timerButton.widthAnchor.constraint(equalTo: viewWithContent.widthAnchor, multiplier: 2 / 3)])
    }

    private func setupCollectionViewConstraints() {
        viewWithContent.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: 20)])
    }

    private func setupCloseButtonConstraints() {
        viewWithContent.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor, constant: 15),
            closeButton.topAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)])
    }

    private func setupPageControlConstraints() {
        viewWithContent.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            pageControl.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor),
            pageControl.widthAnchor.constraint(equalTo: viewWithContent.widthAnchor),
            pageControl.bottomAnchor.constraint(equalTo: timerButton.topAnchor, constant: -35)])
    }

    // MARK: Animations

    private func appearPlateAnimation() {
        plateImageView.alpha = 1
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 2,
                       initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.plateImageViewLeadingConstraint?.constant =
                            -self.plateImageView.frame.width * 0.8
                        self.layoutIfNeeded() })

        UIView.animate(withDuration: 0.3,
                       animations: { self.plateImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) },
                       completion: { _ in UIView.animate(withDuration: 0.4) {
                        self.plateImageView.transform = CGAffineTransform.identity
                       }})
    }

    private func disappearPlateAnimation() {
        UIView.animate(withDuration: 0.1) {
            self.plateImageView.alpha = 0
            self.plateImageViewLeadingConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }

    private func appearContentViewAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2,
                       initialSpringVelocity: 1, options: .curveEaseOut) {
            self.contentViewBottomConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }

    private func disappearContentViewAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.contentViewBottomConstraint?.constant = self.frame.height * 2 / 3
            self.layoutIfNeeded()
        }
    }

    private func appearProductViewAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 0.8,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 3,
            options: .curveEaseOut) {
            self.productNameLabel.transform = .identity
            self.productNameLabel.alpha = 1
            self.productView.transform = .identity
            self.productView.alpha = 1
        }
    }

    private func disappearMascotAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.mascotImageView.alpha = 0
        }
    }

    private func disappearProductViewAnimation() {
        self.productView.alpha = 0
        self.productView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        self.productNameLabel.alpha = 0
        self.productNameLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }

    private func disappearStartCookButtonAnimation() {
        self.startCookButton.alpha = 0
        self.startCookButton.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }

    private func disappearCollectionViewAnimation() {
        collectionView.alpha = 0
        collectionView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        pageControl.alpha = 0
        pageControl.currentPage = 0
        collectionView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
        pageControl.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }

    private func disappearTimerButtonAnimation() {
        self.timerButton.alpha = 0
        self.timerButton.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }

    @objc private func pageControlSelectionAction(_ sender: UIPageControl) {
        let page = sender.currentPage
        collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .left, animated: true)
    }

   private func disappearCloseButtonAnimation() {
        closeButton.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.5) {
            self.closeButton.alpha = 0
        }
    }

    @objc private func startCookButtonTapped() {
        startCookButtonCallBack?()
    }

    @objc private func setTimerButtonTapped() {
        timerButton.layer.removeAllAnimations()
        setTimerButtonCallBack?()
    }

    @objc private func closeButtonTapped() {
        disappearCloseButtonAnimation()
        closeButtonCallBack?()
    }

    // MARK: Public methods

    func startAnimationForFirstStep() {
        appearContentViewAnimation()
    }

    func startAnimationForSecondStep() {
        stillEmpty.alpha = 0
        closeButton.appearCloseButtonAnimation()
        appearContentViewAnimation()
        appearPlateAnimation()
        appearProductViewAnimation()
        startCookButton.appearStartCookButtonAnimation()
        startCookButton.startState()
        disappearCollectionViewAnimation()
        disappearTimerButtonAnimation()
        disappearMascotAnimation()
    }

    func startAnimationForThirdStep() {
        closeButton.alpha = 0
        disappearPlateAnimation()
        disappearProductViewAnimation()
        startCookButton.stopState()
        appearContentViewAnimation()
        startCookButton.appearStartCookButtonAnimation()
        collectionView.appearCollectionViewAnimation()
        collectionView.createLayout()
        pageControl.appearPageControlAnimation()
        timerButton.appearTimerButtonAnimation()
        mascotImageView.appearMascotAnimation()
    }

    func startDisappearAnimations() {
        disappearPlateAnimation()
        disappearContentViewAnimation()
        disappearProductViewAnimation()
        disappearStartCookButtonAnimation()
        disappearCollectionViewAnimation()
        disappearTimerButtonAnimation()
        disappearCloseButtonAnimation()
        disappearMascotAnimation()
    }

    func updateProductImage(image: UIImage?) {
        plateImageView.image = image
    }

    func setBarcode(barcode: String) {
        productView.setBarcode(barcode: barcode)
    }

    func setCategory(category: String) {
        productView.setCategory(category: category)
    }

    func setWeight(weight: String) {
        productView.setWeight(weight: weight)
    }

    func setProducer(producer: String) {
        productView.setProducer(producer: producer)
    }

    func setTime(time: String) {
        productView.setTime(time: time)
    }

    func setName(name: String) {
        productNameLabel.setName(name: name)
    }

    func setupCollectionView<T: UICollectionViewDelegate>(viewController: T)
    where T: UICollectionViewDataSource {
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        collectionView.createLayout()
    }

    func changePageControlPage(page: Int) {
        pageControl.currentPage = page
    }

    func scrollCollectionView(to item: Int) {
        collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .left, animated: true)
    }

    func appearStillEmpty() {
        stillEmpty.alpha = 1
    }
}
