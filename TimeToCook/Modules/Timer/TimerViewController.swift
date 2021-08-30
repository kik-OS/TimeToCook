//
//  TimerVC.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.08.2021.
//

import SwiftUI

final class TimerViewController: UIViewController {
    
    // MARK: UI
    
    private lazy var contentView: TimerContentView = {
        let contentView = TimerContentView()
        return contentView
    }()
    
    private lazy var titleLabel: TimerLabel = {
        let titleLabel = TimerLabel()
        return titleLabel
    }()
    
    private lazy var diagramStackView: TimerStackView = {
        let diagramStackView = TimerStackView()
        return diagramStackView
    }()
    
    private lazy var pickerStackView: TimerStackView = {
        let pickerStackView = TimerStackView()
        return pickerStackView
    }()
    
    private lazy var minutesPickerView: TimerPickerView = {
        let minutesPickerView = TimerPickerView()
        minutesPickerView.delegate = self
        minutesPickerView.dataSource = self
        minutesPickerView.selectRow(viewModel.minutes, inComponent: 0, animated: false)
        return minutesPickerView
    }()
    
    private lazy var minLabel: UILabel = {
        let minLabel = UILabel()
        minLabel.text = "мин"
        minLabel.font = minLabel.font.withSize(22)
        return minLabel
    }()
    
    private lazy var backgroundView: TimerBackgroundView = {
        let backgroundView = TimerBackgroundView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissByTapAction))
        backgroundView.addGestureRecognizer(gesture)
        return backgroundView
    }()
    
    private lazy var closeButton: CloseButtonAdd = {
        let closeButton = CloseButtonAdd()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var startButton: TimerStartButton = {
        let startButton = TimerStartButton()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return startButton
    }()
    
    private lazy var stopButton: TimerStopButton = {
        let stopButton = TimerStopButton()
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        return stopButton
    }()

    // MARK: - Dependences
    
    var viewModel: TimerViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: TimerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelBindings()
        setupAllConstraints()
    }
    
    // MARK: Constraints
    
    private func setupAllConstraints() {
        setupBackgroundViewConstraints()
        setupContentViewConstraints()
        setupCloseButtonConstraints()
        setupTitleLabelConstraints()
        setupDiagramStackViewConstraints()
        setupPickerStackViewConstraints()
        setupMinutesPickerViewConstraints()
        setupStartButtonConstraints()
        setupStopButtonConstraints()
    }
    
    private func setupBackgroundViewConstraints() {
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor)])
    }
    
    private func setupContentViewConstraints() {
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func setupCloseButtonConstraints() {
        contentView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)])
    }
    
    private func setupTitleLabelConstraints() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)])
    }
    
    private func setupDiagramStackViewConstraints() {
        contentView.addSubview(diagramStackView)
        NSLayoutConstraint.activate([
            diagramStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            diagramStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            diagramStackView.widthAnchor.constraint(equalToConstant: 200),
            diagramStackView.heightAnchor.constraint(equalToConstant: 150)])
    }
    
    private func setupPickerStackViewConstraints() {
        contentView.addSubview(pickerStackView)
        NSLayoutConstraint.activate([
            pickerStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            pickerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pickerStackView.heightAnchor.constraint(equalToConstant: 150)])
    }
    
    private func setupMinutesPickerViewConstraints() {
        pickerStackView.addArrangedSubview(minutesPickerView)
        pickerStackView.addArrangedSubview(minLabel)
        minutesPickerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupStartButtonConstraints() {
        contentView.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: pickerStackView.bottomAnchor, constant: 15),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            startButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2 / 3),
            startButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    private func setupStopButtonConstraints() {
        contentView.addSubview(stopButton)
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: pickerStackView.bottomAnchor, constant: 15),
            stopButton.heightAnchor.constraint(equalToConstant: 40),
            stopButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            stopButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2 / 3),
            stopButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        updateStatesOfStackViews()
        updateStatesOfButtons()
        setTimeDiagramView()
    }
    
    // MARK: - Private methods
    
    private func setupViewModelBindings() {
        viewModel.timerDidStep = { [weak self] totalSeconds, remainingSeconds in
            self?.setTimeDiagramView(totalSeconds: totalSeconds, remainingSeconds: remainingSeconds)
        }
        
        viewModel.timerDidStop = { [weak self] in
            self?.hideDiagram()
        }
        
        viewModel.timerDidExpired = { [weak self] in
            self?.stopButton.isHidden = true
        }
    }
    
    private func setTimeDiagramView(totalSeconds: Int? = nil, remainingSeconds: Int? = nil) {
        let totalSeconds = totalSeconds ?? viewModel.timerTime.totalSeconds
        let remainingSeconds = remainingSeconds ?? viewModel.timerTime.remainingSeconds
        let timeDiagramView = UIHostingController(rootView: TimeDiagram(
            width: 200, height: 150,
            totalSeconds: totalSeconds, remainingSeconds: remainingSeconds))
        
        diagramStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        diagramStackView.addArrangedSubview(timeDiagramView.view)
    }
    
    private func updateStatesOfButtons() {
        startButton.isHidden = viewModel.isHiddenStartButton
        stopButton.isHidden = viewModel.isHiddenStopButton
        startButton.isEnabled = viewModel.isEnabledStartButton
    }
    
    private func updateStatesOfStackViews() {
        pickerStackView.isHidden = viewModel.isHiddenPickerStackView
        diagramStackView.isHidden = viewModel.isHiddenDiagramStackView
    }
    
    private func showDiagram() {
        pickerStackView.disappear { [weak self] in
            self?.setTimeDiagramView()
            self?.diagramStackView.appear()
        }
    }
    
    private func hideDiagram() {
        diagramStackView.disappear { [weak self] in
            self?.pickerStackView.appear()
        }
    }
    
    @objc private func dismissByTapAction() {
        dismiss(animated: true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func startButtonTapped() {
        viewModel.startTimer()
        showDiagram()
        updateStatesOfButtons()
    }
    
    @objc private func stopButtonTapped() {
        viewModel.stopTimer()
        hideDiagram()
        updateStatesOfButtons()
    }
}

// MARK: - Picker view data source

extension TimerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { 90 }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(row)"
    }
}

// MARK: - Picker view delegate

extension TimerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.updateTimeTo(minutes: minutesPickerView.selectedRow(inComponent: 0))
        updateStatesOfButtons()
    }
}
