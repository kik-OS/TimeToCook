//
//  CatDownloaderService.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 14.09.2021.
//

/* Данный класс, создан исключительно, для выполнения пункта с загрузкой изображения из сети.
Для активации пасхалки, необходимо открыть экран с таймером,
нажать на пустую область над экраном и держать нажатым 3 секунды.
*/

import Foundation

enum CatDownloaderServiceError: Error {
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

class CatDownloader {

    static let shared = CatDownloader()
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    typealias GetCatImageApiResponse = Result<Data, CatDownloaderServiceError>
    private let session: URLSession = .shared
    private init() {}

    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw CatDownloaderServiceError.network
        }
        return data
    }

    func loadRandomCat(completion: @escaping (GetCatImageApiResponse) -> Void) {
        // Запрос
        guard let url = URL(string: "https://cataas.com/cat") else { completion(.failure(.unknown))
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)

        // обработка
        let handler: Handler = { rawData, response, _ in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                completion(.success(data))
            } catch {
                completion(.failure(.decodable))
            }
        }
        // вызов
        let dataTask = session.dataTask(with: request, completionHandler: handler)
        dataTask.resume()
    }
}
