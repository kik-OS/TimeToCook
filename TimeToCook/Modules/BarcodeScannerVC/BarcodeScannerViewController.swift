//
//  Scan2View.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 19.07.2021.

import UIKit
import AVFoundation

final class BarcodeScannerViewController: UIViewController {
    
    // MARK: Properties
    
    private var scanner: BarcodeScanner?
    weak var delegate: TabBarViewController?
    
    // MARK: UI
    
    private lazy var flashButton: UIButton = {
        let flashButton = FlashButton(frame: CGRect(x: view.frame.width - 80,
                                                    y: view.center.y + 200,
                                                    width: 40, height: 40))
        return flashButton
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = CancelCameraButton(frame: CGRect(x: 15, y: view.center.y + 200,
                                                            width: 120, height: 40))
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return cancelButton
    }()
    
    private lazy var overlayView: UIView = {
        let overlayView = CameraOverlay(frame: view.frame)
        overlayView.addSubview(redLine)
        return overlayView
        
    }()
    
    private lazy var redLine: UIView = {
        let line = UIView(frame: CGRect(x: 25, y: view.center.y - 90,
                                        width: view.frame.width - 50, height: 1))
        line.backgroundColor = .red.withAlphaComponent(0.7)
        return line
    }()
    
    // MARK: Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = BarcodeScanner(withDelegate: self, overlayLayer: overlayView.layer)
        scanner?.requestCaptureSessionStartRunning()
        view.addSubview(flashButton)
        view.addSubview(redLine)
        view.addSubview(cancelButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scanningLineAnimate()
    }
    
    // MARK: Private Methodes
    
    private func scanningLineAnimate() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            self.view.layoutIfNeeded()
            self.redLine.transform = CGAffineTransform(translationX: 0, y: 180)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Extension

extension BarcodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        guard let scanner = scanner else { return }
        scanner.metadataOutput(output, didOutput: metadataObjects, from: connection)
    }
}

extension BarcodeScannerViewController: BarcodeScannerDelegate {
    
    func cameraView() -> UIView { view }
    
    func delegateViewController() -> UIViewController { self }
    
    func scanCompleted(withCode code: String) {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        delegate?.scanner(barcode: code)
        dismiss(animated: true, completion: nil)
    }
}
