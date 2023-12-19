//
//  TouristModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation

struct TouristModel: Identifiable {
    let id: Int
    var firstName: String
    var secondName: String
    var birthDate: String
    var nationality: String
    var passportNumber: String
    var passportEndDate: String
}
