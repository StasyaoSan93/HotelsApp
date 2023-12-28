//
//  TextConstant.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 28.12.2023.
//

import Foundation

enum TextConstants {
    // to Hotel page
    static let hotel: String = "Отель"
    static let aboutHotel: String = "Об отеле"
    static let facilities: String = "Удобства"
    static let included: String = "Что включено"
    static let notIncluded: String = "Что не включено"
    static let essentials: String = "Самое необходимое"
    static let toRoomPage: String = "К выбору номера"
    static func minHotelPrice(price: Int) -> String {
        return "от \(price) ₽"
    }
    
    
    // to Room page
    static let aboutRoom: String = "Подробнее о номере"
    static func forPriceField(price: Int) -> String {
        return "\(price) ₽"
    }
    static let choiseRoom: String = "Выбрать номер"
    
    
    // to Book page
    static let book: String = "Бронирование"
    static let departure: String = "Вылет из"
    static let country: String = "Срана, город"
    static let dates: String = "Даты"
    static let numberOfNights: String = "Кол-во ночей"
    static let room: String = "Номер"
    static let nutrition: String = "Питание"
    static let aboutBuyer: String = "Информация о покупателе"
    static let phoneNumber: String = "Номер телефона"
    static let email: String = "Почта"
    static let bookText: String = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
    static let addTourist: String = "Добавить туриста"
    static let tour: String = "Тур"
    static let fuelCharge: String = "Топливный сбор"
    static let serviceCharge: String = "Сервисный сбор"
    static let toPay: String = "К оплате"
    static func payPrice(price: Int) -> String {
        return "Оплатить \(price) ₽"
    }
    
    static let firstName: String = "Имя"
    static let lastName: String = "Фамилия"
    static let birthDate: String = "Дата рождения"
    static let nationality: String = "Гражданство"
    static let passportNumber: String = "Номер загранпаспорта"
    static let passportEndDate: String = "Срок действия загранпаспорта"
    
    static let firstTourist: String = "Первый турист"
    static let secondTourist: String = "Второй турист"
    static let thirdTourist: String = "Третий турист"
    static let fourthTourist: String = "Четвертый турист"
    static let fifthTourist: String = "Пятый турист"
    static let sixthTourist: String = "Шестой турист"
    static let seventhTourist: String = "Седьмой турист"
    static let eighthTourist: String = "Восьмой турист"
    static let ninethTourist: String = "Девятый турист"
    static let tenthTourist: String = "Десятый турист"
    
    
    // to final view
    static let payed: String = "Заказ оплачен"
    static let finalTextOne: String = "Ваш заказ принят в работу"
    static let finalTextTwo: String = "Подтверждение заказа №\(Int.random(in: 0...1000000)) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
    static let great: String = "Супер!"
    
    
    //genral
    static let icon1: String = "icon1"
    static let icon2: String = "icon2"
    static let icon3: String = "icon3"
    static let chevronRight: String = "chevron.right"
    static let chevronLeft: String = "chevron.left"
    static let chevronUp: String = "chevron.up"
    static let finalImage: String = "finalImage"
    static let starImage: String = "starImage"
    static let phoneMask: String = "+* (***) ***-**-**"
    
    static let hotelInfoURL: String = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    static let roomsInfoURL: String = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
    static let reservationInfoURL: String = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
}
