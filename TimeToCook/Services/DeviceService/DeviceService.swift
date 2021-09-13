//
//  DeviceManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 04.07.2021.
//

import UIKit

// MARK: - Protocol

protocol DeviceServiceProtocol: AnyObject {
    var notSquareScreenDevices: [DeviceModel] { get }
    var currentType: DeviceModel { get set }
    var isSquareScreen: Bool { get }
}

// MARK: - Class

class DeviceService: DeviceServiceProtocol {

    var currentType: DeviceModel
    let notSquareScreenDevices: [DeviceModel] = [.iPhoneX, .iPhoneXS, .iPhoneXSMax,
                                                 .iPhoneXR, .iPhone11, .iPhone11Pro,
                                                 .iPhone11ProMax, .iPhone12, .iPhone12Mini,
                                                 .iPhone12Pro, .iPhone12ProMax]
    init() {
        currentType = UIDevice.current.typeOfCurrentModel
    }

    var isSquareScreen: Bool {
        !notSquareScreenDevices.contains(currentType)
    }
}
