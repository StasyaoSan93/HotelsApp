//
//  HotelViewModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI
import Combine

final class HotelViewModel: ObservableObject {
    
    @Published var hotel: HotelModel = HotelModel(id: 1, name: "", adress: "", minimalPrice: 1, priceForIt: "", rating: 1, ratingName: "", imageUrls: [], aboutTheHotel: AboutTheHotel(description: "", peculiarities: []))
    let loader = DownloadManager()
    var cancellables = Set<AnyCancellable>()
    
    func downloadHotelInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473") else { return }
        
        loader.downloadWithCombine(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: HotelModel.self, decoder: JSONDecoder())
            .sink { _ in
                 
            } receiveValue: { [weak self] hotel in
                self?.hotel = hotel
            }
            .store(in: &cancellables)
    }
}
