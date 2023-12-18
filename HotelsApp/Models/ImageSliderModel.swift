//
//  ImageSliderModel.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 18.12.2023.
//

import Foundation
import SwiftUI

struct ImageSliderModel: Identifiable, Hashable {
    let id = UUID().uuidString
    let image: UIImage
}
