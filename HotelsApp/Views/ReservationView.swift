//
//  ReservationView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

struct ReservationView: View {
    
    @StateObject var vm: ReservationViewModel = ReservationViewModel()
    
    var body: some View {
        ZStack(content: {
            Color.theme.backgroundAll.ignoresSafeArea()
            
            VStack(content: {
                ScrollView(content: {
                    mainCard
                    
                    aboutCard
                    
                    priceCard
                })
            })
        })
        .onAppear(perform: {
            vm.downloadReservationInfo()
        })
    }
}

#Preview {
    ReservationView()
}

extension ReservationView {
    private var mainCard: some View {
        VStack(spacing: 5, content: {
            HotelsApp.ratingField(number: "\(vm.reservation.horating)", description: vm.reservation.ratingName)
            
            Text(vm.reservation.hotelName)
                .font(.system(size: 22))
                .foregroundStyle(Color.theme.blackText)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {}, label: {
                Text(vm.reservation.hotelAdress)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.theme.blueText)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
            })
        })
        .padding(20)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(15)
    }
    
    private var aboutCard: some View {
        VStack(spacing: 8, content: {
            customTextField(leftText: "Вылет из", rightText: vm.reservation.departure, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: "Срана, город", rightText: vm.reservation.arrivalCountry, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: "Даты", rightText: "\(vm.reservation.tourDateStart) - \(vm.reservation.tourDateStop)", rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: "Кол-во ночей", rightText: "\(vm.reservation.numberOfNights)", rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: "Отель", rightText: vm.reservation.hotelName, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: "Номер", rightText: vm.reservation.room, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: "Питание", rightText: vm.reservation.nutrition, rightTrailing: false, rightBlueColor: false)
        })
        .padding(.vertical, 20)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(15)
    }
    
    private var priceCard: some View {
        VStack(spacing: 8, content: {
            customTextField(leftText: "Тур", rightText: "\(vm.reservation.tourPrice) ₽", rightTrailing: true, rightBlueColor: false)
            
            customTextField(leftText: "Топливный сбор", rightText: "\(vm.reservation.fuelCharge) ₽", rightTrailing: true, rightBlueColor: false)
            
            customTextField(leftText: "Сервисный сбор", rightText: "\(vm.reservation.serviceCharge) ₽", rightTrailing: true, rightBlueColor: false)
            
            customTextField(leftText: "К оплате", rightText: "\(vm.reservation.tourPrice + vm.reservation.fuelCharge + vm.reservation.serviceCharge) ₽", rightTrailing: true, rightBlueColor: true)
        })
        .padding(.vertical, 20)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(15)
    }
    
    private func customTextField(leftText: String, rightText: String, rightTrailing: Bool, rightBlueColor: Bool) -> some View {
        HStack(alignment: .top, content: {
            Text(leftText)
                .foregroundStyle(Color.theme.grayText)
                .frame(width: UIScreen.main.bounds.width/2.7, alignment: .leading)
            
            if rightTrailing {
                Spacer()
            }
            
            Text(rightText)
                .foregroundStyle(rightBlueColor ? Color.theme.blueText : Color.theme.blackText)
        })
        .font(.system(size: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}
