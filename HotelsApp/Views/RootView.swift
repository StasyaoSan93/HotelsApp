//
//  RootView.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 20.12.2023.
//

import SwiftUI

final class ScreenNavigationClass: ObservableObject {
    @Published var screen: String = "Hotel"
}

struct RootView: View {
    
    @EnvironmentObject private var screen: ScreenNavigationClass
    @EnvironmentObject private var main: MainViewModel
    
    var body: some View {
        ZStack(content: {
            Color.theme.backgroundAll.ignoresSafeArea()
            
            switch screen.screen {
            case "Hotel":
                HotelView()
            case "Room":
                RoomsView()
            case "Book":
                ReservationView()
            case "Final":
                FinalView()
            default:
                HotelView()
            }
        })
    }
}

#Preview {
    RootView()
        .environmentObject(ScreenNavigationClass())
        .environmentObject(MainViewModel())
}
