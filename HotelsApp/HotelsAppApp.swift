//
//  HotelsAppApp.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import SwiftUI

@main
struct HotelsAppApp: App {
    
    @StateObject private var screen: ScreenNavigationClass = ScreenNavigationClass()
    @StateObject private var main: MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(screen)
                .environmentObject(main)
        }
    }
}
