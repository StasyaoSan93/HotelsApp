//
//  PayedView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 20.12.2023.
//

import SwiftUI

struct FinalView: View {
    
    @EnvironmentObject private var screen: ScreenNavigationClass
    @State private var topSafeArea: CGFloat = 0
    @State private var bottomSafeArea: CGFloat = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(content: {
                Color.theme.backgroundWhite.ignoresSafeArea()
                
                VStack(content: {
                    header
                    
                    Spacer()
                    
                    main
                    
                    Spacer()
                    
                    Divider()
                    bottomButton
                })
                .padding(.horizontal)
                .ignoresSafeArea()
                .onAppear(perform: {
                    topSafeArea = geometry.safeAreaInsets.top
                    bottomSafeArea = geometry.safeAreaInsets.bottom
                })
            })
        })
    }
}

extension FinalView {
    private var header: some View {
        HStack(content: {
            Button(action: {
                screen.screen = .book
            }, label: {
                Image(systemName: TextConstants.chevronLeft)
            })
            
            Spacer()
            
            Text(TextConstants.payed)
            
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
        .background {
            Color.theme.backgroundWhite
        }
        .cornerRadius(12)
    }
    
    private var main: some View {
        VStack(spacing: 8, content: {
            Image(TextConstants.finalImage, bundle: nil)
                .resizable()
                .frame(width: 94, height: 94)
            
            Text(TextConstants.finalTextOne)
                .font(.system(size: 22))
                .foregroundStyle(Color.theme.blackText)
            
            Text(TextConstants.finalTextTwo)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .foregroundStyle(Color.theme.grayText)
        })
    }
    
    private var bottomButton: some View {
        VStack(content: {
            Button(action: {
                screen.screen = .hotel
            }, label: {
                Text(TextConstants.great)
            })
            .withCustomButtonStyle()
        })
        .padding(.bottom, bottomSafeArea + 12)
    }
}

#Preview {
    FinalView()
        .environmentObject(ScreenNavigationClass())
}
