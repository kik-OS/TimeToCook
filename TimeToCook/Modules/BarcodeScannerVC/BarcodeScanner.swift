//
//  Scan2.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 19.07.2021.
//

import UIKit
import AVFoundation

protocol BarcodeScannerDelegate: AnyObject {
    func cameraView() -> UIView
    func delegateViewController() -> UIViewController
    func scanCompleted(withCode code: String)
}

final class BarcodeScanner {
    
    // MARK: Properties
    
    public weak var delegate: BarcodeScannerDelegate?
    private var captureSession: AVCaptureSession?
    private var overlayLayer: CALayer?
    
    // MARK: Init
    
    init(withDelegate delegate: BarcodeScannerDelegate, overlayLayer: CALayer) {
        self.overlayLayer = overlayLayer
        self.delegate = delegate
        scannerSetup()
    }
    
    // MARK: Private Methodes
    
    private func scannerSetup() {
        guard let captureSession = createCaptureSession() else { return }
        self.captureSession = captureSession
        guard let delegate = delegate else { return }
        
        let cameraView = delegate.cameraView()
        let previewLayer = createPreviewLayer(withCaptureSession: captureSession,
                                              view: cameraView)
        cameraView.layer.addSublayer(previewLayer)
    }
    
    private func createCaptureSession() -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return nil }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            let metaDataOutput = AVCaptureMetadataOutput()
            
            if captureSession.canAddInput(deviceInput) && captureSession.canAddOutput(metaDataOutput) {
                captureSession.addInput(deviceInput)
                captureSession.addOutput(metaDataOutput)
                
                guard let delegate = delegate,
                      let viewController = delegate.delegateViewController()
                        as? AVCaptureMetadataOutputObjectsDelegate else { return nil }
                
                metaDataOutput.setMetadataObjectsDelegate(viewController, queue: DispatchQueue.main)
                metaDataOutput.metadataObjectTypes = metaObjectTypes()
                return captureSession
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func createPreviewLayer(withCaptureSession captureSession: AVCaptureSession,
                                    view: UIView) -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.addSublayer(overlayLayer ?? CALayer())
        return previewLayer
    }
    
    private func metaObjectTypes() -> [AVMetadataObject.ObjectType] {
        [.qr, .code128, .code39, .code39Mod43,
         .code93, .ean13, .ean8, .interleaved2of5,
         .itf14, .pdf417, .upce]
    }
    
    private func toggleCaptureSessionRunningState() {
        guard let captureSession = captureSession else { return }
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        } else {
            captureSession.stopRunning()
        }
    }
    
    // MARK: Public Methods
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        requestCaptureSessionStopRunning()
        
        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let scannedValue = readableObject.stringValue,
              let delegate = delegate else { return }
        
        delegate.scanCompleted(withCode: scannedValue)
    }
    
    public func requestCaptureSessionStartRunning() {
        toggleCaptureSessionRunningState()
    }
    
    public func requestCaptureSessionStopRunning() {
        toggleCaptureSessionRunningState()
    }
    
}
