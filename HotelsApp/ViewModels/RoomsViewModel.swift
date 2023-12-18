//
//  RoomsViewModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI
import Combine

final class RoomsViewModel: ObservableObject {
    
    @Published var rooms: RoomsModel = RoomsModel(rooms: [RoomModel(id: 1, name: "", price: 1, pricePer: "", peculiarities: [], imageUrls: [])])
    let loader = DownloadManager()
    var cancellables = Set<AnyCancellable>()
    
    func downloadRoomsInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195") else { return }
        
        loader.downloadWithCombine(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: RoomsModel.self, decoder: JSONDecoder())
            .sink { _ in
                 
            } receiveValue: { [weak self] rooms in
                self?.rooms = rooms
            }
            .store(in: &cancellables)
    }
}
