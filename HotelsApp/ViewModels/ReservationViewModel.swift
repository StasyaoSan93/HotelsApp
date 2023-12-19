//
//  ReservationViewModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI
import Combine

final class ReservationViewModel: ObservableObject {
    
    @Published var reservation: ReservationModel = ReservationModel(id: 1, hotelName: "", hotelAdress: "", horating: 1, ratingName: "", departure: "", arrivalCountry: "", tourDateStart: "", tourDateStop: "", numberOfNights: 1, room: "", nutrition: "", tourPrice: 1, fuelCharge: 1, serviceCharge: 1)
    let loader = DownloadManager()
    var cancellables = Set<AnyCancellable>()
    
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
            .store(in: &cancellables)
    }
    
    func addTourist() {
        let quantity = tourists.count
        if quantity < 10 {
            tourists.append(TouristModel(id: quantity + 1, firstName: "", secondName: "", birthDate: "", nationality: "", passportNumber: "", passportEndDate: ""))
        }
    }
    
    func checkTourist() -> Bool {
        for tourist in tourists {
            if tourist.firstName.isEmpty || tourist.secondName.isEmpty || tourist.birthDate.isEmpty || tourist.nationality.isEmpty || tourist.passportNumber.isEmpty || tourist.passportEndDate.isEmpty {
                return false
            }
        }
        return true
    }
}
