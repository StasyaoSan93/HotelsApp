//
//  ReitingField.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI

func ratingField(number: String, description: String) -> some View {
    HStack {
        HStack(content: {
            Image("starImage", bundle: nil)
                .resizable()
                .frame(width: 15, height: 15)
            Text(number)
            Text(description)
        })
        .font(.system(size: 18))
        .foregroundStyle(Color.theme.orangeText)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background {
            Color.theme.orangeBack
        }
        .cornerRadius(5)
        
        Spacer()
    }
}
