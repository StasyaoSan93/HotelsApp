//
//  ImageDownloader.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI
import Combine

final class ImageDownloader: ObservableObject {
    @Published var imagesList: [ImageSliderModel] = []
    let loader = DownloadManager()
    var cancellables = Set<AnyCancellable>()
    
    func downloadImage(url: [String]) {
        for string in url {
            guard let url = URL(string: string) else { return }
            
            loader.downloadWithCombine(url: url)
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    
                } receiveValue: { image in
                    if let image = UIImage(data: image) {
                        self.imagesList.append(ImageSliderModel(image: image))
                    }
                }
                .store(in: &cancellables)
        }
    }
}
