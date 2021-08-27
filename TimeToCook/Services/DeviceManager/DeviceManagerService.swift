//
//  DeviceManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 04.07.2021.
//

import UIKit

protocol DeviceServiceProtocol {
    func checkSquareScreen() -> Bool
}

struct DeviceManagerService: DeviceServiceProtocol {
    
    let notSquareScreenDevices: [DeviceModel] = [.iPhoneX, .iPhoneXS, .iPhoneXSMax,
                                                 .iPhoneXR, .iPhone11, .iPhone11Pro,
                                                 .iPhone11ProMax, .iPhone12, .iPhone12Mini,
                                                 .iPhone12Pro, .iPhone12ProMax]
    func checkSquareScreen() -> Bool {
        let type = UIDevice.current.typeOfCurrentModel
        return !notSquareScreenDevices.contains(type)
    }
}
