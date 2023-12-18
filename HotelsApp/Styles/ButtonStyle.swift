//
//  ButtonStyle.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18))
            .foregroundColor(Color.theme.textWhite)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(Color.theme.buttonColor)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
