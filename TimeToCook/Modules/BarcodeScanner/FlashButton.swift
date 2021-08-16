//
//  FlashButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 21.07.2021.
//

import UIKit
import AVFoundation

final class FlashButton: UIButton {
    
    //MARK: Properties
    
    private var flashIsOn = false
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(flash), for: .touchUpInside)
        backgroundColor = .black.withAlphaComponent(0.3)
        layer.cornerRadius = frame.width / 2
        setImage(UIImage(systemName: "bolt.fill"), for: .normal)
        changeTintColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methodes 
    
    @objc private func flash() {
        flashIsOn.toggle()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        flashIsOn ? turnOnTorch(device: device) : turnOffTorch(device: device)
        changeTintColor()
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
    
    private func changeTintColor() {
        tintColor = flashIsOn ? .yellow : .white
    }
}
