//
//  Color+DarkLightMode.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 03.05.2025.
//

import SwiftUI

extension Color {
    /**
     Initializes a `Color` that adapts to the current system color scheme (light or dark mode).
     
     - Parameters:
     - light: The color to be used in light mode.
     - dark: The color to be used in dark mode.
     
     This uses UIKit's dynamic color system under the hood via `UIColor`.
     
     ### Example:
     ```swift
     Color(light: .black, dark: .white)
     ```
    */
    init(light: Color, dark: Color) {
        self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
    }
}

extension UIColor {
    /**
     Initializes a `UIColor` that dynamically switches between light
     and dark variants based on the system's interface style.

     - Parameters:
       - light: The color to use in light mode.
       - dark: The color to use in dark mode.

     Useful for creating adaptive UI elements that respond to light/dark appearance changes.
    */
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}
