//
//  BaseVC.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 14.09.2021.
//

/* Данный класс, создан исключительно, для выполнения пункта с загрузкой изображения из сети.
Для активации пасхалки, необходимо открыть экран с таймером,
нажать на пустую область над экраном и держать нажатым 3 секунды.
*/

import UIKit

class BaseViewController: UIViewController {

    private let spinner = SpinnerViewController()

    var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            showSpinner(isShown: isLoading)
        }
    }

    private func showSpinner(isShown: Bool) {
        if isShown {
            addChild(spinner)
            spinner.view.frame = view.frame
            view.addSubview(spinner.view)
            spinner.didMove(toParent: self)
        } else {
            spinner.willMove(toParent: nil)
            spinner.view.removeFromSuperview()
            spinner.removeFromParent()
        }
    }
}
