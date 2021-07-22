//
//  ProductInfoViewController2.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 22.07.2021.
//

import UIKit

class ProductInfoViewController2: UIViewController {
    
    private lazy var productImage: UIImageView = {
        
        guard let image = UIImage(named: "plate") else { return UIImageView() }
        let productImage = UIImageView(image: image)
        productImage.contentMode = .scaleAspectFit
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.layer.shadowRadius = 5
        productImage.layer.shadowOpacity = 0.2
        productImage.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        productImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        productImage.clipsToBounds = false
        return productImage
    }()
    
    private lazy var viewWithContent: UIView = {
        let viewWithContent = UIView()
        viewWithContent.layer.shadowRadius = 5
        viewWithContent.layer.shadowOpacity = 0.2
        viewWithContent.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        viewWithContent.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewWithContent.layer.cornerRadius = 20
        viewWithContent.backgroundColor = .white
        viewWithContent.clipsToBounds = false
        viewWithContent.translatesAutoresizingMaskIntoConstraints = false
        return viewWithContent
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addVerticalGradientLayer(topColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), bottomColor: #colorLiteral(red: 0.8979474902, green: 0.9020553231, blue: 0.8977640867, alpha: 1))
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        view.addSubview(viewWithContent)
        NSLayoutConstraint.activate([
            viewWithContent.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewWithContent.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            viewWithContent.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor, multiplier: 0.56),
            productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor),
            productImage.centerYAnchor.constraint(equalTo: viewWithContent.topAnchor, constant: -20),
            productImage.centerXAnchor.constraint(equalTo: viewWithContent.centerXAnchor, constant: 50)
        ])
    }
    
    //Gradient
    private func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
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
