//
//  EasterCatVC.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 14.09.2021.
//

import UIKit

final class EasterCatViewController: BaseViewController {

    fileprivate let catDownloader = CatDownloader.shared

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.setTitle("Random", for: .normal)
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        randomButton.addTarget(self, action: #selector(loadRandomCat), for: .touchUpInside)
        return randomButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupConstraints()
        loadRandomCat()
    }

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
            let alert = UIAlertController(title: "Упс, что-то пошло не так!",
                                          message: error.message,
                                          preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }

    private func setupConstraints() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            randomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            randomButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            randomButton.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}












fileprivate class CatDownloader {

    typealias GetCatImageApiResponse = Result<Data, CatDownloaderServiceError>

    static let shared = CatDownloader()
    private init() {}

    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    private let session: URLSession = .shared

    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw CatDownloaderServiceError.network
        }
        return data
    }

    func loadRandomCat(completion: @escaping (GetCatImageApiResponse) -> Void) {
        // request
        guard let url = URL(string: "https://cataas.com/cat") else { completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)

        // hadler
        let handler: Handler = { rawData, response, _ in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                completion(.success(data))
            } catch {
                completion(.failure(.decodable))
            }
        }
        // call
        let dataTask = session.dataTask(with: request, completionHandler: handler)
        dataTask.resume()
    }
}

fileprivate enum CatDownloaderServiceError: Error {
    case network
    case decodable
    case unknown

    var message: String {
        switch self {
        case .network:
            return "Что-то с интернетом"
        case .decodable:
            return "Не смогли корректно отобразить данные"
        case .unknown:
            return "????"
        }
    }
}









