//
//  Scan2View.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 19.07.2021.
//

import Foundation

import UIKit
import AVFoundation

final class BarcodeScannerViewController: UIViewController {
    
    private var scanner: BarcodeScanner?
    weak var delegate: CustomTabBarController?
    
    private lazy var flashButton: UIButton = {
        let flashButton = FlashButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return flashButton
    }()
    
    private lazy var overlayView: UIView = {
        let overlayView = CameraOverlay(frame: view.frame)
        overlayView.addSubview(line)
        return overlayView
        
    }()
    
    private lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 15, y: view.center.y - 100 , width: view.frame.width - 30, height: 1))
        line.backgroundColor = .red
        line.tintColor = .red
        return line
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = BarcodeScanner(withDelegate: self, overlayLayer: overlayView.layer)
        scanner?.requestCaptureSessionStartRunning()
        view.addSubview(flashButton)
        view.addSubview(line)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scanningLineAnimate()
    }
    
    private func scanningLineAnimate() {
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse]) { [self] in
            self.view.layoutIfNeeded()
            line.transform = CGAffineTransform(translationX: 0, y: 200)
        }
    }
}

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
