//
//  ProductInfoViewController.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 22.07.2021.
//

import UIKit

/// Данный протокол добавлен для декомпозиции контролера 
// MARK: Protocol

protocol ChangeRootViewProtocol {
    associatedtype RootView: UIView
}

extension ChangeRootViewProtocol where Self: UIViewController {
    func view() -> RootView? {
        self.view as? RootView
    }
}

// MARK: Class

final class ProductInfoViewController: UIViewController, ChangeRootViewProtocol {

    typealias RootView = ProductInfoRootView

    // MARK: Dependences

    var viewModel: ProductInfoViewModelProtocol

    // MARK: Init

    init(viewModel: ProductInfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func loadView() {
        view = ProductInfoRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBindingsForAnimation()
        setupViewBinding()
        view()?.setupCollectionView(viewController: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.checkCurrentStateAndUpdateView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view()?.startDisappearAnimations()
    }

    // MARK: Private Methodes

    private func setupViewModelBindingsForAnimation() {
        viewModel.needUpdateViewForFirstStep = { [weak self] in
            self?.view()?.startAnimationForFirstStep()
        }

        viewModel.needUpdateViewForSecondStep = { [weak self] in
            self?.view()?.startAnimationForSecondStep()
            self?.updateProductInfo()
        }

        viewModel.needUpdateViewForThirdStep = { [weak self] in
            self?.view()?.startAnimationForThirdStep()
        }
    }

    private func updateProductInfo() {
        view()?.updateProductImage(image: UIImage(named: viewModel.productImage))
        view()?.setBarcode(barcode: viewModel.product?.code ?? "")
        view()?.setCategory(category: viewModel.product?.category ?? "")
        view()?.setWeight(weight: viewModel.weight)
        view()?.setProducer(producer: viewModel.product?.producer ?? "")
        view()?.setTime(time: viewModel.cookingTime)
        view()?.setName(name: viewModel.product?.title ?? "")
    }

    private func setupViewBinding() {
        view()?.startCookButtonCallBack = { [weak self] in
            self?.viewModel.buttonStartCookTapped.toggle()
            self?.viewModel.checkCurrentStateAndUpdateView()
        }

        view()?.setTimerButtonCallBack = { [weak self] in
            guard  let self = self else { return }
            let timerVC = self.viewModel.getTimerViewController()
            timerVC.modalPresentationStyle = .overCurrentContext
            /// Если у пользователя выключены уведомления, вызывается Alert с предложением о включении
            self.viewModel.getNotificationService.checkNotificationSettings { [weak self] in
                guard let alert = self?.viewModel.getNotificationService.notificationsAreNotAvailableAlert() else {
                    return
                }
                self?.present(alert, animated: true)
            }
            self.present(timerVC, animated: true)
        }

        view()?.closeButtonCallBack = { [weak self] in
            self?.view()?.startDisappearAnimations()
            self?.viewModel.updateProduct(product: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.viewModel.checkCurrentStateAndUpdateView()
                self?.view()?.appearStillEmpty()
            }
        }
    }
}

// MARK: UICollectionViewDelegate

extension ProductInfoViewController: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        view()?.changePageControlPage(page: currentPage)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        view()?.changePageControlPage(page: currentPage)
    }
}

// MARK: UICollectionViewDataSource

extension ProductInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int { 7 }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "instructionCell",
                                                            for: indexPath) as?
                InstructionCollectionViewCell else { return UICollectionViewCell() }
        cell.setViewModel(viewModel: viewModel.cellViewModel(at: indexPath))
        return cell
    }
}
