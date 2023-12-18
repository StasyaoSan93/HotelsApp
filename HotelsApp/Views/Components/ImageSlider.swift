//
//  ImageSlider.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

struct ImageSlider: View {
    let slider: [ImageSliderModel]
    @State private var selection: String = ""
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                ForEach(slider) { image in
                    Image(uiImage: image.image)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 25)
                        .background(Color.theme.backgroundWhite)
                        .cornerRadius(15)
                        .tag(image.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 257)
            
            HStack {
                ForEach(slider) { select in
                    Circle()
                        .fill(select.id == selection ? Color.black : Color.black.opacity(0.22))
                        .frame(width: 7, height: 7)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.white)
            .cornerRadius(5)
            .offset(y: 110)
        }
        .onAppear {
            selection = slider.first?.id ?? ""
        }
    }
}

#Preview {
    ZStack(content: {
        Color.theme.backgroundAll.ignoresSafeArea()
        
        ImageSlider(slider: [ImageSliderModel(image: UIImage(named: "starImage")!), ImageSliderModel(image: UIImage(named: "starImage")!)])
    })
}
