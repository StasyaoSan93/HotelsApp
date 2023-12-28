//
//  RootView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 20.12.2023.
//

import SwiftUI

final class ScreenNavigationClass: ObservableObject {
    @Published var screen: NavigateScreens = .hotel
}

struct RootView: View {
    
    @EnvironmentObject private var screen: ScreenNavigationClass
    @EnvironmentObject private var main: MainViewModel
    
    var body: some View {
        ZStack(content: {
            Color.theme.backgroundAll.ignoresSafeArea()
            
            switch screen.screen {
            case .hotel:
                HotelView()
            case .room:
                RoomsView()
            case .book:
                ReservationView()
            case .final:
                FinalView()
            }
        })
    }
}

#Preview {
    RootView()
        .environmentObject(ScreenNavigationClass())
        .environmentObject(MainViewModel())
}
