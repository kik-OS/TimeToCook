//
//  ProductInfoViewController2.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 22.07.2021.
//

import UIKit

final class ProductInfoViewController2: UIViewController {
    
    //MARK: UI
    
    private lazy var viewWithContent: ViewWithContent = {
        let viewWithContent = ViewWithContent()
        return viewWithContent
    }()
    
    private lazy var plateImageView: PlateImageView = {
        let plateImageView = PlateImageView()
        return plateImageView
    }()
    

    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addVerticalGradientLayer()
        setupAllConstraints()
    }
    
    //MARK: AutoLayout
    
    private func setupAllConstraints() {
        setupViewWithContentConstraints()
        setupPlateImageViewConstraints()
    }
    
    private func setupPlateImageViewConstraints() {
        view.addSubview(plateImageView)
        NSLayoutConstraint.activate([
            plateImageView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 0.56),
            plateImageView.widthAnchor.constraint(equalTo: plateImageView.heightAnchor),
            plateImageView.centerYAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: -20),
            plateImageView.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor, constant: 50)])
    }
    
    private func setupViewWithContentConstraints() {
        view.addSubview(viewWithContent)
        NSLayoutConstraint.activate([
            viewWithContent.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewWithContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            viewWithContent.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    //MARK: Private Methodes
    
    //Gradient
    private func addVerticalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor, #colorLiteral(red: 0.8979474902, green: 0.9020553231, blue: 0.8977640867, alpha: 1).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    //NavigationBar
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
}
