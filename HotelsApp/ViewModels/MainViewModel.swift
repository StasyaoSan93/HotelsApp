//
//  HotelViewModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    let loader = DownloadManager()
    
    //Hotel View
    @Published var hotel: HotelModel = HotelModel(id: 1, name: "", adress: "", minimalPrice: 1, priceForIt: "", rating: 1, ratingName: "", imageUrls: [], aboutTheHotel: AboutTheHotel(description: "", peculiarities: []))
    var hotelCancellables = Set<AnyCancellable>()
    
    func downloadHotelInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473") else { return }
        
        loader.downloadWithCombine(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: HotelModel.self, decoder: JSONDecoder())
            .sink { _ in
                 
            } receiveValue: { [weak self] hotel in
                self?.hotel = hotel
            }
            .store(in: &hotelCancellables)
    }
    
    //Room View
    @Published var rooms: RoomsModel = RoomsModel(rooms: [RoomModel(id: 1, name: "", price: 1, pricePer: "", peculiarities: [], imageUrls: [])])
    var roomCancellables = Set<AnyCancellable>()
    
    func downloadRoomsInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195") else { return }
        
        loader.downloadWithCombine(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: RoomsModel.self, decoder: JSONDecoder())
            .sink { _ in
                 
            } receiveValue: { [weak self] rooms in
                self?.rooms = rooms
            }
            .store(in: &roomCancellables)
    }
    
    //Reservation View
    @Published var reservation: ReservationModel = ReservationModel(id: 1, hotelName: "", hotelAdress: "", horating: 1, ratingName: "", departure: "", arrivalCountry: "", tourDateStart: "", tourDateStop: "", numberOfNights: 1, room: "", nutrition: "", tourPrice: 1, fuelCharge: 1, serviceCharge: 1)
    var bookCancellables = Set<AnyCancellable>()
    @Published var tourists: [TouristModel] = [TouristModel(id: 1, firstName: "", secondName: "", birthDate: "", nationality: "", passportNumber: "", passportEndDate: "")]
    @Published var checkFieldStatus: Bool = true
    @Published var phoneNumber: String = ""
    @Published var userEmail: String = ""
    
    func downloadReservationInfo() {
        guard let url = URL(string: "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff") else { return }
        
        loader.downloadWithCombine(url: url)
            .receive(on: DispatchQueue.main)
            .decode(type: ReservationModel.self, decoder: JSONDecoder())
            .sink { _ in
                 
            } receiveValue: { [weak self] reservation in
                self?.reservation = reservation
            }
            .store(in: &bookCancellables)
    }
    
    func addTourist() {
        let quantity = tourists.count
        if quantity < 10 {
            tourists.append(TouristModel(id: quantity + 1, firstName: "", secondName: "", birthDate: "", nationality: "", passportNumber: "", passportEndDate: ""))
        }
    }
    
    func checkTourist() -> Bool {
        for tourist in tourists {
            if tourist.firstName.isEmpty || tourist.secondName.isEmpty || tourist.birthDate.isEmpty || tourist.nationality.isEmpty || tourist.passportNumber.isEmpty || tourist.passportEndDate.isEmpty || phoneNumber.isEmpty || (phoneNumber.count < 11) || userEmail.isEmpty || !userEmail.isValidEmail() {
                return false
            }
        }
        return true
    }
}
