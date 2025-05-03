//
//  Color+HEX.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 03.05.2025.
//

import SwiftUI

extension Color {
    init(hex: UInt32) {
        let red, green, blue, alpha: Double
        if hex > 0xFFFFFF {
            red = Double((hex >> 24) & 0xFF) / 255.0
            green = Double((hex >> 16) & 0xFF) / 255.0
            blue = Double((hex >> 8) & 0xFF) / 255.0
            alpha = Double(hex & 0xFF) / 255.0
        } else {
            red = Double((hex >> 16) & 0xFF) / 255.0
            green = Double((hex >> 8) & 0xFF) / 255.0
            blue = Double(hex & 0xFF) / 255.0
            alpha = 1.0
        }
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
