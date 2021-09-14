//
//  SpinnerVC.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 14.09.2021.
//

/* Данный класс, создан исключительно, для выполнения пункта с загрузкой изображения из сети.
Для активации пасхалки, необходимо открыть экран с таймером,
нажать на пустую область над экраном и держать нажатым 3 секунды.
*/

import UIKit

class SpinnerViewController: UIViewController {

    private let spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.color = .white
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
