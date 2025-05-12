//
//  Color+DarkLightMode.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 03.05.2025.
//

import SwiftUI

extension Color {
    /**
     Initializer for light and dark mode switching.
     
     - Parameters:
        - light: The color to use in light mode.
        - dark: The color to use in dark mode.
    */
    init(light: Color, dark: Color) {
        self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
    }
}

extension UIColor {
    /**
     Initializer for light and dark mode switching

     - Parameters:
       - light: The color to use in light mode.
       - dark: The color to use in dark mode.
    */
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}
