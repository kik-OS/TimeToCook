//
//  Scan2View.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 19.07.2021.
//

import Foundation

import UIKit
import AVFoundation

class Scan2View: UIViewController, AVCaptureMetadataOutputObjectsDelegate, ScannerDelegate {
    private var scanner: Scanner2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scanner = Scanner2(withDelegate: self)
        
        guard let scanner = self.scanner else {
            return
        }
        
        scanner.requestCaptureSessionStartRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark - AVFoundation delegate methods
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        guard let scanner = self.scanner else {
            return
        }
        scanner.metadataOutput(output,
                               didOutput: metadataObjects,
                               from: connection)
    }
    
    // Mark - Scanner delegate methods
    func cameraView() -> UIView
    {
        return self.view
    }
    
    func delegateViewController() -> UIViewController
    {
        return self
    }
    
    func scanCompleted(withCode code: String)
    {
        print(code)
    }
}
