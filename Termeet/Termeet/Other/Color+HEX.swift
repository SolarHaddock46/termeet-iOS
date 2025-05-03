//
//  Color+HEX.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 03.05.2025.
//

import SwiftUI

extension Color {
    /**
     Initializes a `Color` from a hexadecimal value.
     
     - If the `hex` value contains **8 digits** (e.g. `0xRRGGBBAA`), it extracts red, green, blue, and alpha components.
     - If the `hex` value contains **6 digits** (e.g. `0xRRGGBB`), it assumes full opacity (`alpha = 1.0`).
     
     ### Examples:
     ```swift
     Color(hex: 0xFF0000)       // Red
     Color(hex: 0x00FF0080)     // Semi-transparent green
     ```
     
     - Parameter hex: A 6-digit or 8-digit hexadecimal integer representing the color.
    */
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
