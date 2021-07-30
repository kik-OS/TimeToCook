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
    
    private lazy var stillEmpty: StillEmptyView = {
        let stillEmpty = StillEmptyView()
        return stillEmpty
    }()
    
    
    //MARK: Properties
    
    private var plateImageViewLeadingConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addVerticalGradientLayer()
        setupAllConstraints()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearAnimations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disappearAnimations()
    }
    
    //MARK: AutoLayout
    
    private func setupAllConstraints() {
        setupViewWithContentConstraints()
        setupPlateImageViewConstraints()
        setupStillEmptyViewConstraints()
    }
    
    private func setupViewWithContentConstraints() {
        view.addSubview(viewWithContent)
        contentViewBottomConstraint = viewWithContent.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                              constant: view.frame.height * 2/3)
        contentViewBottomConstraint?.isActive = true
        NSLayoutConstraint.activate([viewWithContent.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     viewWithContent.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                                             multiplier: 2/3)])
    }
    
    private func setupPlateImageViewConstraints() {
        view.addSubview(plateImageView)
        plateImageViewLeadingConstraint = plateImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor)
        plateImageViewLeadingConstraint?.isActive = true
        
        NSLayoutConstraint.activate([plateImageView.heightAnchor.constraint(equalTo: viewWithContent.heightAnchor,
                                                                            multiplier: 0.56),
                                     plateImageView.widthAnchor.constraint(equalTo: plateImageView.heightAnchor),
                                     plateImageView.centerYAnchor.constraint(equalTo: viewWithContent.topAnchor,
                                                                             constant: -20)])
    }
    
    private func setupStillEmptyViewConstraints() {
        viewWithContent.addSubview(stillEmpty)
        NSLayoutConstraint.activate([stillEmpty.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor,
                                                                         constant: 8),
                                     stillEmpty.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor,
                                                                          constant: -8),
                                     stillEmpty.topAnchor.constraint(equalTo: plateImageView.bottomAnchor, constant: 15)
        ])
    }
    
    
    //MARK: Animations
    
    private func appearAnimations() {
        appearPlateAnimation()
        appearContentViewAnimation()
    }
    
    private func disappearAnimations() {
        disappearPlateAnimation()
        disappearContentViewAnimation()
    }
    
    private func appearPlateAnimation() {
        plateImageView.alpha = 1
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                        self.plateImageViewLeadingConstraint?.constant = -self.plateImageView.frame.width * 0.8
                        self.plateImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
                        self.view.layoutIfNeeded()
                       })
    }
    
    
    private func disappearPlateAnimation() {
        UIView.animate(withDuration: 0.1) {
            self.plateImageView.alpha = 0
            self.plateImageViewLeadingConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func appearContentViewAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2,
                       initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.contentViewBottomConstraint?.constant = 0
                        self.view.layoutIfNeeded()
                       })
    }
    
    private func disappearContentViewAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.contentViewBottomConstraint?.constant = self.view.frame.height * 2/3
            self.view.layoutIfNeeded()
            
        }
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
