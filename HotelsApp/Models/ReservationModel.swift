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
}
