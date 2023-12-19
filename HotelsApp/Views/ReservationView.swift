//
//  ReservationView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

struct ReservationView: View {
    
    @StateObject var vm: ReservationViewModel = ReservationViewModel()
    @State private var bottomSafeArea: CGFloat = 0
    
    var body: some View {
        ZStack(content: {
            Color.theme.backgroundAll.ignoresSafeArea()
            
            GeometryReader(content: { geometry in
                ScrollView(content: {
                    mainCard
                    
                    aboutCard
                    
                    personalInformationCard
                    
                    touristsCards
                    
                    addTouristCard
                    
                    priceCard
                    
                    bottomButton
                })
                .ignoresSafeArea(edges: .bottom)
                .onAppear(perform: {
                    bottomSafeArea = geometry.safeAreaInsets.bottom
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
    
    private var personalInformationCard: some View {
        VStack(content: {
            HStack(content: {
                Text("Информация о покупателе")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blackText)
                
                Spacer()
            })
            
            customTextFieldWithError(hintText: "Номер телефона", backColor: true, fieldText: $vm.phoneNumber, fieldType: .phone)
            
            customTextFieldWithError(hintText: "Почта", backColor: true, fieldText: $vm.userEmail, fieldType: .email)
            
            Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                .font(.system(size: 14))
                .foregroundStyle(Color.theme.grayText)
                .frame(maxWidth: .infinity, alignment: .leading)
        })
        .padding(20)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(15)
    }
    
    private var touristsCards: some View {
        VStack(content: {
            ForEach($vm.tourists) { tourist in
                touristCard(tourist: tourist, fieldColor: vm.checkFieldStatus)
            }
        })
    }
    
    private var addTouristCard: some View {
        HStack(content: {
            Text("Добавить туриста")
                .font(.system(size: 22))
                .foregroundStyle(Color.theme.blackText)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    vm.addTourist()
                }
            }, label: {
                Image(systemName: "plus")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blueText)
                    .frame(width: 32, height: 32)
                    .background {
                        Color.theme.blueText.opacity(0.1)
                    }
                    .cornerRadius(6)
            })
        })
        .padding(20)
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
    
    private var bottomButton: some View {
        VStack(content: {
            Button(action: {
                vm.checkFieldStatus = vm.checkTourist()
            }, label: {
                Text("Оплатить \(vm.reservation.tourPrice + vm.reservation.fuelCharge + vm.reservation.serviceCharge) ₽")
            })
            .withCustomButtonStyle()
        })
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, bottomSafeArea + 12)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(12)
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

struct touristCard: View {
    @Binding var tourist: TouristModel
    @State private var minimizeView: Bool = false
    let fieldColor: Bool
    
    var body: some View {
        VStack(content: {
            HStack(content: {
                cardTitle(id: tourist.id)
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blackText)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        minimizeView.toggle()
                    }
                }, label: {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.theme.blueText)
                        .rotationEffect(.degrees(minimizeView ? 180 : 0))
                        .frame(width: 32, height: 32)
                        .background {
                            Color.theme.blueText.opacity(0.1)
                        }
                        .cornerRadius(6)
                })
            })
            
            if !minimizeView {
                customTextFieldWithError(hintText: "Имя", backColor: fieldColor, fieldText: $tourist.firstName, fieldType: .info)
                customTextFieldWithError(hintText: "Фамилия", backColor: fieldColor, fieldText: $tourist.secondName, fieldType: .info)
                customTextFieldWithError(hintText: "Дата рождения", backColor: fieldColor, fieldText: $tourist.birthDate, fieldType: .info)
                customTextFieldWithError(hintText: "Гражданство", backColor: fieldColor, fieldText: $tourist.nationality, fieldType: .info)
                customTextFieldWithError(hintText: "Номер загранпаспорта", backColor: fieldColor, fieldText: $tourist.passportNumber, fieldType: .info)
                customTextFieldWithError(hintText: "Срок действия загранпаспорта", backColor: fieldColor, fieldText: $tourist.passportEndDate, fieldType: .info)
            }
        })
        .padding(20)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(15)
        .onAppear(perform: {
            if tourist.id > 1 {
                minimizeView = true
            }
        })
    }
    
    func cardTitle(id: Int) -> some View {
        switch id {
        case 1:
            Text("Первый турист")
        case 2:
            Text("Второй турист")
        case 3:
            Text("Третий турист")
        case 4:
            Text("Четвертый турист")
        case 5:
            Text("Пятый турист")
        case 6:
            Text("Шестой турист")
        case 7:
            Text("Седьмой турист")
        case 8:
            Text("Восьмой турист")
        case 9:
            Text("Девятый турист")
        case 10:
            Text("Десятый турист")
        default:
            Text("")
        }
    }
}
