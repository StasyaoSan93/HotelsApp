//
//  JSONDecoder.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 28.12.2023.
//

import Foundation

extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
