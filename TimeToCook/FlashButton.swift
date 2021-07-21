//
//  FlashButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 21.07.2021.
//

import UIKit
import AVFoundation

final class FlashButton: UIButton {
    
    private var flashIsOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(flash), for: .touchUpInside)
        changeImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func flash() {
        flashIsOn.toggle()
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        flashIsOn ? turnOnTorch(device: device) : turnOffTorch(device: device)
        changeImage()
    }
    
    private func turnOnTorch(device: AVCaptureDevice) {
        guard device.hasTorch else { return }
        withDeviceLock(on: device) {
            try? $0.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
        }
    }
    
    private func withDeviceLock(on device: AVCaptureDevice, block: (AVCaptureDevice) -> Void) {
        do {
            try device.lockForConfiguration()
            block(device)
            device.unlockForConfiguration()
        } catch {
            
        }
    }
    
    private func turnOffTorch(device: AVCaptureDevice) {
        guard device.hasTorch else { return }
        withDeviceLock(on: device) {
            $0.torchMode = .off
        }
    }
    
    private func changeImage() {
        setImage(UIImage(named: flashIsOn ? "flashOn": "flashOff"), for: .normal)
    }
    
}
