//
//  Hotel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

struct HotelView: View {
    
    @EnvironmentObject private var screen: ScreenNavigationClass
    @EnvironmentObject private var main: MainViewModel
    @StateObject private var ivm: ImageDownloader = ImageDownloader()
    
    @State private var topSafeArea: CGFloat = 0
    @State private var bottomSafeArea: CGFloat = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(content: {
                Color.theme.backgroundAll.ignoresSafeArea()
                
                ScrollView {
                    hotelMainCard
                    
                    aboutHotelCard
                    
                    bottomButton
                }
                .ignoresSafeArea()
                .onAppear(perform: {
                    topSafeArea = geometry.safeAreaInsets.top
                    bottomSafeArea = geometry.safeAreaInsets.bottom
                    main.downloadHotelInfo()
                })
                .onReceive(main.$hotel, perform: { hotel in
                    if !hotel.imageUrls.isEmpty {
                        ivm.downloadImage(url: hotel.imageUrls)
                    }
                })
            })
        })
    }
}

#Preview {
    HotelView()
        .environmentObject(ScreenNavigationClass())
        .environmentObject(MainViewModel())
}

extension HotelView {
    private var hotelMainCard: some View {
        VStack(content: {
            Text(TextConstants.hotel)
                .font(.system(size: 18))
                .foregroundStyle(Color.theme.blackText)
                .padding(.top, topSafeArea)
            
            ImageSlider(slider: ivm.imagesList)
            
            HotelsApp.ratingField(number: "\(main.hotel.rating)", description: main.hotel.ratingName)
                .padding(.horizontal, 12)
            
            VStack(spacing: 8, content: {
                Text(main.hotel.name)
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blackText)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {}, label: {
                    Text(main.hotel.adress)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.theme.blueText)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
                
                HStack(content: {
                    Text(TextConstants.minHotelPrice(price: main.hotel.minimalPrice))
                        .font(.system(size: 30))
                        .foregroundStyle(Color.theme.blackText)
                        .fontWeight(.semibold)
                    
                    Text(main.hotel.priceForIt)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.theme.grayText)
                        .fontWeight(.medium)
                    
                    Spacer()
                })
            })
            .padding(.horizontal, 12)
        })
        .padding(.bottom, 8)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(12)
    }

    private var aboutHotelCard: some View {
        VStack(content: {
            HStack(content: {
                Text(TextConstants.aboutHotel)
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blackText)
                Spacer()
            })
            
            VStack(content: {
                ForEach(main.hotel.aboutTheHotel.peculiarities, id: \.self) { peculiarity in
                    Text(peculiarity)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.theme.grayText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background {
                            Color.theme.backgroundForField
                        }
                        .cornerRadius(5)
                }
            })
            
            Text(main.hotel.aboutTheHotel.description)
                .font(.system(size: 16))
                .foregroundStyle(Color.theme.blackText.opacity(0.9))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(content: {
                aboutHotelField(icon: TextConstants.icon1, text: TextConstants.facilities, bottomDivider: true)
                
                aboutHotelField(icon: TextConstants.icon2, text: TextConstants.included, bottomDivider: true)
                
                aboutHotelField(icon: TextConstants.icon3, text: TextConstants.notIncluded, bottomDivider: false)
            })
            .padding(.vertical, 20)
            .background {
                Color.theme.backgroundForField
            }
            .cornerRadius(15)
        })
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(12)
    }
    
    private func aboutHotelField(icon: String, text: String, bottomDivider: Bool) -> some View {
        VStack(content: {
            HStack(content: {
                Image(icon, bundle: nil)
                    .resizable()
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading ,content: {
                    Text(text)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.theme.blackText)
                    Text(TextConstants.essentials)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.theme.grayText)
                })
                Spacer()
                Image(systemName: TextConstants.chevronRight)
            })
            .padding(.horizontal, 30)
            
            if bottomDivider {
                Divider()
                    .padding(.leading, 60)
                    .padding(.trailing, 30)
            }
        })
    }
    
    private var bottomButton: some View {
        VStack(content: {
            Button(action: {
                screen.screen = .room
            }, label: {
                Text(TextConstants.toRoomPage)
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
}
