//
//  ReservationView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

struct ReservationView: View {
    
    @EnvironmentObject private var screen: ScreenNavigationClass
    @EnvironmentObject private var main: MainViewModel
    @State private var topSafeArea: CGFloat = 0
    @State private var bottomSafeArea: CGFloat = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(content: {
                Color.theme.backgroundAll.ignoresSafeArea()
                
                VStack(content: {
                    header
                    
                    ScrollView(content: {
                        mainCard
                        
                        aboutCard
                        
                        personalInformationCard
                        
                        touristsCards
                        
                        addTouristCard
                        
                        priceCard
                        
                        bottomButton
                    })
                })
                .ignoresSafeArea()
            })
            .onAppear(perform: {
                topSafeArea = geometry.safeAreaInsets.top
                bottomSafeArea = geometry.safeAreaInsets.bottom
                main.downloadReservationInfo()
            })
        })
    }
}

#Preview {
    ReservationView()
        .environmentObject(ScreenNavigationClass())
        .environmentObject(MainViewModel())
}

extension ReservationView {
    private var header: some View {
        HStack(content: {
            Button(action: {
                screen.screen = .room
            }, label: {
                Image(systemName: TextConstants.chevronLeft)
            })
            
            Spacer()
            
            Text(TextConstants.book)
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: TextConstants.chevronLeft)
                    .opacity(0.0)
            })
        })
        .font(.system(size: 18))
        .foregroundStyle(Color.theme.blackText)
        .padding(.top, topSafeArea)
        .padding(.bottom)
        .padding(.horizontal)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(12)
    }
    
    private var mainCard: some View {
        VStack(spacing: 5, content: {
            HotelsApp.ratingField(number: "\(main.reservation.horating)", description: main.reservation.ratingName)
            
            Text(main.reservation.hotelName)
                .font(.system(size: 22))
                .foregroundStyle(Color.theme.blackText)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {}, label: {
                Text(main.reservation.hotelAdress)
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
            customTextField(leftText: TextConstants.departure, rightText: main.reservation.departure, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.country, rightText: main.reservation.arrivalCountry, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.dates, rightText: "\(main.reservation.tourDateStart) - \(main.reservation.tourDateStop)", rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.numberOfNights, rightText: "\(main.reservation.numberOfNights)", rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.hotel, rightText: main.reservation.hotelName, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.room, rightText: main.reservation.room, rightTrailing: false, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.nutrition, rightText: main.reservation.nutrition, rightTrailing: false, rightBlueColor: false)
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
                Text(TextConstants.aboutBuyer)
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blackText)
                
                Spacer()
            })
            
            customTextFieldWithError(hintText: TextConstants.phoneNumber, backColor: main.checkFieldStatus, fieldText: $main.phoneNumber, fieldType: .phone)
            
            customTextFieldWithError(hintText: TextConstants.email, backColor: main.checkFieldStatus, fieldText: $main.userEmail, fieldType: .email)
            
            Text(TextConstants.bookText)
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
            ForEach($main.tourists) { tourist in
                touristCard(tourist: tourist, fieldColor: main.checkFieldStatus)
            }
        })
    }
    
    private var addTouristCard: some View {
        HStack(content: {
            Text(TextConstants.addTourist)
                .font(.system(size: 22))
                .foregroundStyle(Color.theme.blackText)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    main.addTourist()
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
            customTextField(leftText: TextConstants.tour, rightText: TextConstants.forPriceField(price: main.reservation.tourPrice), rightTrailing: true, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.fuelCharge, rightText: TextConstants.forPriceField(price: main.reservation.fuelCharge), rightTrailing: true, rightBlueColor: false)
            
            customTextField(leftText: TextConstants.serviceCharge, rightText: TextConstants.forPriceField(price: main.reservation.serviceCharge), rightTrailing: true, rightBlueColor: false)

            customTextField(leftText: TextConstants.toPay, rightText: TextConstants.forPriceField(price: main.reservation.tourPrice + main.reservation.fuelCharge + main.reservation.serviceCharge), rightTrailing: true, rightBlueColor: true)
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
                main.checkFieldStatus = main.checkTourist()
                if main.checkFieldStatus {
                    screen.screen = .final
                }
            }, label: {
                Text(TextConstants.payPrice(price: main.reservation.tourPrice + main.reservation.fuelCharge + main.reservation.serviceCharge))
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
                    Image(systemName: TextConstants.chevronUp)
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
                customTextFieldWithError(hintText: TextConstants.firstName, backColor: fieldColor, fieldText: $tourist.firstName, fieldType: .info)
                customTextFieldWithError(hintText: TextConstants.lastName, backColor: fieldColor, fieldText: $tourist.secondName, fieldType: .info)
                customTextFieldWithError(hintText: TextConstants.birthDate, backColor: fieldColor, fieldText: $tourist.birthDate, fieldType: .info)
                customTextFieldWithError(hintText: TextConstants.nationality, backColor: fieldColor, fieldText: $tourist.nationality, fieldType: .info)
                customTextFieldWithError(hintText: TextConstants.passportNumber, backColor: fieldColor, fieldText: $tourist.passportNumber, fieldType: .info)
                customTextFieldWithError(hintText: TextConstants.passportEndDate, backColor: fieldColor, fieldText: $tourist.passportEndDate, fieldType: .info)
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
            Text(TextConstants.firstTourist)
        case 2:
            Text(TextConstants.secondTourist)
        case 3:
            Text(TextConstants.thirdTourist)
        case 4:
            Text(TextConstants.fourthTourist)
        case 5:
            Text(TextConstants.fifthTourist)
        case 6:
            Text(TextConstants.sixthTourist)
        case 7:
            Text(TextConstants.seventhTourist)
        case 8:
            Text(TextConstants.eighthTourist)
        case 9:
            Text(TextConstants.ninethTourist)
        case 10:
            Text(TextConstants.tenthTourist)
        default:
            Text("")
        }
    }
}
