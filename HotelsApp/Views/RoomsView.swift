//
//  RoomView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

struct RoomsView: View {
    
    @StateObject var vm: RoomsViewModel = RoomsViewModel()
    
    var body: some View {
        ZStack(content: {
            Color.theme.backgroundAll.ignoresSafeArea()
            
            ScrollView {
                ForEach(vm.rooms.rooms, id: \.self) { room in
                    RoomCard(room: room)
                }
            }
        })
        .onAppear(perform: {
            vm.downloadRoomsInfo()
        })
    }
}

#Preview {
    RoomsView()
}

struct RoomCard: View {
    
    @StateObject var ivm: ImageDownloader = ImageDownloader()
    let room: RoomModel
    
    var body: some View {
        VStack(content: {
            ImageSlider(slider: ivm.imagesList)
            
            VStack(content: {
                Text(room.name)
                    .font(.system(size: 22))
                    .foregroundStyle(Color.theme.blackText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(content: {
                        ForEach(room.peculiarities, id:\.self) { peculiarity in
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
                }
                
                HStack(content:  {
                    Button(action: {}, label: {
                        HStack(content:  {
                            Text("Подробнее о номере")
                            Image(systemName: "chevron.right")
                        })
                        .font(.system(size: 16))
                        .foregroundStyle(Color.theme.blueText)
                        .fontWeight(.medium)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            Color.theme.blueText.opacity(0.1)
                        }
                        .cornerRadius(10)
                    })
                    
                    Spacer()
                })
                
                HStack(alignment: .bottom, content:  {
                    Text("\(room.price) ₽")
                        .font(.system(size: 30))
                        .foregroundStyle(Color.theme.blackText)
                        .fontWeight(.medium)
                    
                    Text(room.pricePer)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.theme.grayText)
                        .fontWeight(.medium)
                        .offset(y: -3)
                    
                    Spacer()
                })
                
                Button(action: {}, label: {
                    Text("Выбрать номер")
                })
                .withCustomButtonStyle()
            })
            .padding(.horizontal, 12)
            
        })
        .padding(.vertical, 16)
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(12)
        .onAppear(perform: {
            ivm.downloadImage(url: room.imageUrls)
        })
    }
}
