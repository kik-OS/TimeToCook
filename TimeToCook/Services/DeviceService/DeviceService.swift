//
//  DeviceManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 04.07.2021.
//

import UIKit

protocol DeviceServiceProtocol {
    var notSquareScreenDevices: [DeviceModel] { get }
    var currentType: DeviceModel { get set }
    func checkSquareScreen() -> Bool
}

struct DeviceService: DeviceServiceProtocol {

    var currentType: DeviceModel
    let notSquareScreenDevices: [DeviceModel] = [.iPhoneX, .iPhoneXS, .iPhoneXSMax,
                                                 .iPhoneXR, .iPhone11, .iPhone11Pro,
                                                 .iPhone11ProMax, .iPhone12, .iPhone12Mini,
                                                 .iPhone12Pro, .iPhone12ProMax]
    init() {
        currentType = UIDevice.current.typeOfCurrentModel
    }

    func checkSquareScreen() -> Bool {
        return !notSquareScreenDevices.contains(currentType)
    }

}
