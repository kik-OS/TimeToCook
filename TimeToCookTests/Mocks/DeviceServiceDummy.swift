//
//  DeviceManagerDummy.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 31.08.2021.
//

import Foundation

final class DeviceServiceDummy: DeviceServiceProtocol {

    var notSquareScreenDevices: [DeviceModel] = []
    var currentType: DeviceModel = .iPhone11
    func checkSquareScreen() -> Bool { false }
}
