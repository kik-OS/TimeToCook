//
//  Add2VC.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 07.08.2021.
//

import UIKit

final class AddingNewProductViewController: UIViewController {

    // MARK: - UI
    
    private lazy var contentView: UIView = {
       let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var contentScroll: ContentScroll = {
       let contentScroll = ContentScroll()
        contentScroll.backgroundColor = .white
        return contentScroll
    }()
    
    private lazy var closeButton: AddCloseButton = {
        let closeButton = AddCloseButton()
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var textFieldsStackView: TextFieldStackView = {
        let textFieldsStackView = TextFieldStackView()
        return textFieldsStackView
    }()
    
    private lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        return codeLabel
    }()
    
    private lazy var saveButton: SaveProductButton = {
        let saveButton = SaveProductButton()
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return saveButton
    }()
    
    private lazy var categorySV: SingleStackAddView = {
        let categorySV = SingleStackAddView(viewModel: SingleStackAddViewModel(textFieldType: .category))
        return categorySV
    }()
    
    private lazy var titleProductSV: SingleStackAddView = {
        let titleProductSV = SingleStackAddView(viewModel: SingleStackAddViewModel(textFieldType: .productLabel))
        return titleProductSV
    }()
    
    private lazy var producerSV: SingleStackAddView = {
        let producerSV = SingleStackAddView(viewModel: SingleStackAddViewModel(textFieldType: .producer))
        return producerSV
    }()
    
    private lazy var cookingTimeSV: SingleStackAddView = {
        let cookingTimeSV = SingleStackAddView(viewModel: SingleStackAddViewModel(textFieldType: .time))
        return cookingTimeSV
    }()
    
    private lazy var weightSV: SingleStackAddView = {
        let weightSV = SingleStackAddView(viewModel: SingleStackAddViewModel(textFieldType: .weight))
        return weightSV
    }()
    
    private lazy var waterRatioSV: SingleStackAddView = {
        let waterRatioSV = SingleStackAddView(viewModel: SingleStackAddViewModel(textFieldType: .waterRatio))
        return waterRatioSV
    }()
    
    // MARK: - Private Properties

    private let pickerViewForKB = UIPickerView()
    private let doneButtonForKB = UIBarButtonItem()
    private let downButtonForKB = UIBarButtonItem()
    private let upButtonForKB = UIBarButtonItem()
    private var textFields: Set<UITextField> = []
   
    
    // MARK: - Dependences

    var viewModel: AddingNewProductViewModelProtocol!

  

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        codeLabel.text = viewModel.codeLabelText
        addToolBar()
        initializePickerView()
        configureObservers()
        configureGestureRecognizer()
        setupViewModelBindings()
        setupAllConstraints()
        view.backgroundColor = .systemBackground
    }

    // MARK: - Private Methodes
    
    private func setupAllConstraints() {
        setupContentScrollConstraints()
        setupContentViewConstraints()
        setupCloseButtonConstraints()
        setupTextFieldsStackViewConstraints()
        setupSaveProductButtonConstraints()
        setupStack()
    }
    
    private func setupContentScrollConstraints() {
        view.addSubview(contentScroll)
        NSLayoutConstraint.activate([
            contentScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentScroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    private func setupContentViewConstraints() {
        contentScroll.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: contentScroll.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentScroll.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentScroll.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentScroll.contentLayoutGuide.trailingAnchor)])
        
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: contentScroll.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        NSLayoutConstraint.activate([contentView.centerXAnchor.constraint(equalTo: contentScroll.centerXAnchor),
            contentViewCenterY, contentViewHeight])
    }
    
    private func setupCloseButtonConstraints() {
       contentScroll.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)])
    }
    
    private func setupTextFieldsStackViewConstraints() {
        contentView.addSubview(textFieldsStackView)
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            textFieldsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textFieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)])
    }
    
    private func setupSaveProductButtonConstraints() {
        contentView.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3),
            saveButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 25),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    private func setupStack() {
        textFieldsStackView.addArrangedSubview(codeLabel)
        textFieldsStackView.addArrangedSubview(categorySV)
        textFieldsStackView.addArrangedSubview(titleProductSV)
        textFieldsStackView.addArrangedSubview(producerSV)
        textFieldsStackView.addArrangedSubview(cookingTimeSV)
        textFieldsStackView.addArrangedSubview(weightSV)
        textFieldsStackView.addArrangedSubview(waterRatioSV)
    }
    
    private func setupTextFields() {
        textFields.insert(categorySV.getTF())
        textFields.insert(titleProductSV.getTF())
        textFields.insert(producerSV.getTF())
        textFields.insert(cookingTimeSV.getTF())
        textFields.insert(weightSV.getTF())
        textFields.insert(waterRatioSV.getTF())
        addTargetsToTextFields()
    }
    
    private func addTargetsToTextFields() {
        textFields.forEach {
            $0.addTarget(self, action: #selector(textFieldsEditingDidBegin), for: .editingDidBegin)
            $0.addTarget(self, action: #selector(textFieldsEditingChanged), for: .editingChanged)
        }
    }
    
    private func setupViewModelBindings() {
        viewModel.needUpdateTextFieldWithPickerView = { [unowned self] type, text in
            switch type {
            case .category:
                categorySV.getTF().text = text
            case .waterRatio:
                waterRatioSV.getTF().text = text
            }
        }

        viewModel.needUpdateFirstResponder = { [unowned self] tag in
            guard let targetTF = textFields.first(where: { $0.tag == tag}) else { return }
            targetTF.becomeFirstResponder()
        }
    }

    private func configureGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(oneTouchOnScrollView))
        contentScroll.addGestureRecognizer(recognizer)
    }

    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }


   @objc private func textFieldsEditingDidBegin(_ sender: UITextField) {
        viewModel.indexOfFirstResponder = sender.tag
        viewModel.updatePickerViewIfNeeded(index: sender.tag) { [weak self] in
            self?.pickerViewForKB.reloadAllComponents()
        }
        updateUpAndDownButtonsState()
    }

    @objc private func textFieldsEditingChanged(_ sender: UITextField) {
        switch sender {
        case titleProductSV.getTF():
            viewModel.textFromTitleProductTF = sender.text
        case producerSV.getTF():
            viewModel.textFromProducerTF = sender.text
        case cookingTimeSV.getTF():
            viewModel.textFromCookingTimeTF = sender.text
        case weightSV.getTF():
            viewModel.textFromWeightTF = sender.text
        default:
            break
        }
        updateSaveButtonsState()
    }
        
    @objc private func closeButtonPressed() {
         dismiss(animated: true)
     }

    @objc private func saveButtonPressed() {
        viewModel.createProductInFB()
        Notifications.shared.showProductWasAddedNotification()
        
//        guard let productInfoVC = tabBarController?.viewControllers?.first as? ProductInfoViewController else { return }
//        productInfoVC.viewModel.updateProduct(product: viewModel.completedProduct)
//        tabBarController?.selectedViewController = tabBarController?.viewControllers?.first
        
//        let productInfoVC = ProductInfoViewController()
//        productInfoVC.
//        productInfoVC.viewModel = viewModel.getProductInfoViewModel()
//        performSegue(withIdentifier: Inscriptions.unwindToProductInfoSegueID, sender: nil)
//        productInfoVC.viewModel.updateProduct(product: viewModel.completedProduct)
    }

    // MARK: - Private Methods
   

}

//MARK: - Extensions

extension AddingNewProductViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.didTapChangeResponderButton(type: .down)
        return true
    }

    @objc private func oneTouchOnScrollView() {
        view.endEditing(true)
    }

    @objc private func didTapOnDoneButton() {
        saveButtonPressed()
    }

    @objc private func didTapOnUpButton() {
        viewModel.didTapChangeResponderButton(type: .up)
    }

    @objc private func didTapOnDownButton() {
        viewModel.didTapChangeResponderButton(type: .down)
    }

    @objc private func keyBoardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        contentScroll.contentSize = CGSize(width: view.bounds.size.width,
                                                     height: view.bounds.size.height + kbFrameSize.height + 40)
        contentScroll.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }

    @objc private func keyBoardDidHide() {
        contentScroll.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
    }

    private func updateSaveButtonsState() {
        let state = viewModel.validation()
        saveButton.isEnabled = state
        doneButtonForKB.isEnabled = state
    }

    private func updateUpAndDownButtonsState() {
        upButtonForKB.isEnabled = viewModel.stateForUpButton
        downButtonForKB.isEnabled = viewModel.stateForDownButton
    }

    private func createToolBar() -> UIToolbar {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        keyboardToolbar.sizeToFit()

        doneButtonForKB.tintColor = .white
        doneButtonForKB.isEnabled = false
        doneButtonForKB.title = Inscriptions.titleOfDoneButtonForKB
        doneButtonForKB.style = .plain
        doneButtonForKB.action = #selector(didTapOnDoneButton)

        downButtonForKB.tintColor = .white
        downButtonForKB.action = #selector(didTapOnDownButton)
        downButtonForKB.image = UIImage(systemName: ImageTitles.toolBarDownButton)
        downButtonForKB.style = .plain

        upButtonForKB.tintColor = .white
        upButtonForKB.action = #selector(didTapOnUpButton)
        upButtonForKB.image = UIImage(systemName: ImageTitles.toolBarUpButton)
        upButtonForKB.style = .plain

        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 14

        keyboardToolbar.items = [downButtonForKB, space, upButtonForKB, flexBarButton, doneButtonForKB]
        keyboardToolbar.backgroundColor = VarkaColors.mainColor
        keyboardToolbar.barTintColor = VarkaColors.mainColor
        keyboardToolbar.updateConstraintsIfNeeded()
        return keyboardToolbar
    }

    private func addToolBar() {
        let keyboardToolbar = createToolBar()
        textFields.forEach { textField in
            textField.delegate = self
            textField.inputAccessoryView = keyboardToolbar
        }
    }
}

extension AddingNewProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    private func initializePickerView() {
        categorySV.getTF().inputView = pickerViewForKB
        waterRatioSV.getTF().inputView = pickerViewForKB
        pickerViewForKB.delegate = self
        pickerViewForKB.translatesAutoresizingMaskIntoConstraints = false
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView,
                     numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRowsInPickerView
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int,
                     forComponent component: Int) -> String? {
        viewModel.dataForPickerView[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int,
                     inComponent component: Int) {
        viewModel.pickerViewDidSelectAt(row: row)
        updateSaveButtonsState()
    }
}
