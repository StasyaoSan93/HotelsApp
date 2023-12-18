//
//  DownloadManager.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI
import Combine

class DownloadManager {
    func handleResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300
        else {
            throw URLError(.badURL)
        }
        return data
    }

    func downloadWithCombine(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
}
