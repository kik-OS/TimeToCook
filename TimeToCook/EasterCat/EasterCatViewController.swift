//
//  EasterCatVC.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 14.09.2021.
//

/* Данный класс, создан исключительно, для выполнения пункта с загрузкой изображения из сети.
 Для активации пасхалки, необходимо открыть экран с таймером,
 нажать на пустую область над экраном и держать нажатым 3 секунды.
 */

import UIKit

final class EasterCatViewController: BaseViewController {

    // MARK: UI

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                  width: view.frame.width,
                                                  height: view.frame.height))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var randomButton: CancelCameraButton = {
        let randomButton = CancelCameraButton(frame: CGRect(x: 0,
                                                            y: view.frame.height - 150,
                                                            width: view.frame.width * 0.6,
                                                            height: 40))
        randomButton.addTarget(self, action: #selector(loadRandomCat), for: .touchUpInside)
        randomButton.setTitle("Котогенератор", for: .normal)
        return randomButton
    }()

    // MARK: Service

    private let catDownloader = CatDownloader.shared
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(randomButton)
        loadRandomCat()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        randomButton.frame.origin.x = view.bounds.midX - randomButton.bounds.midX
    }

    // MARK: Private Methodes

    @objc func loadRandomCat() {
        isLoading = true
        catDownloader.loadRandomCat { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self.imageView.image = image
                case .failure(let error):
                    self.showAlert(for: error)
                }
                self.isLoading = false
            }
        }
    }

    private func showAlert(for error: CatDownloaderServiceError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "С котиками какие-то проблемы",
                                          message: error.message,
                                          preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
}
