//
//  ReservationModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation

/*
 {
   "id": 1,
   "hotel_name": "Лучший пятизвездочный отель в Хургаде, Египет",
   "hotel_adress": "Madinat Makadi, Safaga Road, Makadi Bay, Египет",
   "horating": 5,
   "rating_name": "Превосходно",
   "departure": "Москва",
   "arrival_country": "Египет, Хургада",
   "tour_date_start": "19.09.2023",
   "tour_date_stop": "27.09.2023",
   "number_of_nights": 7,
   "room": "Люкс номер с видом на море",
   "nutrition": "Все включено",
   "tour_price": 289400,
   "fuel_charge": 9300,
   "service_charge": 2150
 }
*/

struct ReservationModel: Codable {
    let id: Int
    let hotelName, hotelAdress: String
    let horating: Int
    let ratingName, departure, arrivalCountry, tourDateStart: String
    let tourDateStop: String
    let numberOfNights: Int
    let room, nutrition: String
    let tourPrice, fuelCharge, serviceCharge: Int

    enum CodingKeys: String, CodingKey {
        case id
        case hotelName = "hotel_name"
        case hotelAdress = "hotel_adress"
        case horating
        case ratingName = "rating_name"
        case departure
        case arrivalCountry = "arrival_country"
        case tourDateStart = "tour_date_start"
        case tourDateStop = "tour_date_stop"
        case numberOfNights = "number_of_nights"
        case room, nutrition
        case tourPrice = "tour_price"
        case fuelCharge = "fuel_charge"
        case serviceCharge = "service_charge"
    }
}
