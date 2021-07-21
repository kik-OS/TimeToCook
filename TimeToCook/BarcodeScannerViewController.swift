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
    
   private lazy var overlayLayer: CALayer = {
    let overlayView = CameraOverlay(frame: view.frame)
    return overlayView.layer
    
   }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner = BarcodeScanner(withDelegate: self, overlayLayer: overlayLayer)
        scanner?.requestCaptureSessionStartRunning()
        view.addSubview(flashButton)
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
