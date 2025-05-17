//
//  ConfirmButton.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 17.05.2025.
//

import SwiftUI

private enum Constants {
    enum Colors {
        static let background: Color = Color(light: .init(hex: 0x2F2F2F), dark: .init(hex: 0x2F2F2F))
        static let titleText: Color = Color(light: .init(hex: 0xFFFFFF), dark: .init(hex: 0xFFFFFF))
        static let headerText: Color = Color(light: .init(hex: 0x959595), dark: .init(hex: 0x959595))
        static let footerText: Color = Color(light: .init(hex: 0x386DD4), dark: .init(hex: 0x386DD4))
    }

    enum Fonts {
        static let titleText: Font = .system(size: 17, weight: .regular)
        static let headerText: Font = .system(size: 17, weight: .regular)
        static let footerText: Font = .system(size: 17, weight: .regular)
    }

    enum Sizes {
        static let heightButton: CGFloat = 43
        static let cornerRadius: CGFloat = 10
        static let verticalSpacing: CGFloat = 20
    }
}

struct ConfirmButtonConfiguration {
    var title: String
    var titleFont: Font = Constants.Fonts.titleText
    var titleColor: Color = Constants.Colors.titleText

    var action: (() -> Void)?
    var isEnabled: Bool = true

    var headerText: String?
    var headerFont: Font = Constants.Fonts.headerText
    var headerColor: Color = Constants.Colors.headerText

    var backgroundColor: Color = Constants.Colors.background

    var footerTextButton: String?
    var footerTextFont: Font = Constants.Fonts.footerText
    var footerTextColor: Color = Constants.Colors.footerText
    var footerTextActionButton: (() -> Void)?

    mutating func update(_ changes: (inout ConfirmButtonConfiguration) -> Void) {
        changes(&self)
    }
}

struct ConfirmButton: View {
    private var configuration: ConfirmButtonConfiguration

    init(configuration: ConfirmButtonConfiguration = .init(title: "Test")) {
        self.configuration = configuration
    }

    init(title: String) {
        self.configuration = .init(title: title)
    }

    var body: some View {
        VStack(spacing: Constants.Sizes.verticalSpacing) {
            header
            mainButton
            footerButton
        }

    }
}

// MARK: Subviews

private extension ConfirmButton {
    var mainButton: some View {
        Button(action: configuration.action ?? {}) {
            RoundedRectangle(cornerRadius: Constants.Sizes.cornerRadius)
                .foregroundStyle(configuration.backgroundColor)
                .overlay(alignment: .center) {
                    Text(configuration.title)
                        .font(configuration.titleFont)
                        .foregroundStyle(configuration.titleColor)
                }
                .frame(maxHeight: Constants.Sizes.heightButton)
        }
        .buttonStyle(.plain)
        .disabled(!configuration.isEnabled)
    }

    var footerButton: some View {
        Group {
            if let text = configuration.footerTextButton {
                Button(action: configuration.footerTextActionButton ?? {}) {
                    Text(text)
                        .font(configuration.footerTextFont)
                        .foregroundStyle(configuration.footerTextColor)
                }
            }
        }
    }

    var header: some View {
        HStack {
            if let text = configuration.headerText {
                Text(text)
                    .font(configuration.headerFont)
                    .foregroundStyle(configuration.headerColor)
            }
            Spacer()
        }
    }
}

// MARK: Modifiers

extension ConfirmButton {
    func updateConfiguration(_ changes: (inout ConfirmButtonConfiguration) -> Void) -> Self {
        var view = self
        view.configuration.update(changes)
        return view
    }

    func setTitle(text: String?, font: Font? = nil, color: Color?) -> Self {
        updateConfiguration {
            if let text { $0.title = text }
            if let font { $0.titleFont = font }
            if let color { $0.titleColor = color }
        }
    }

    func setAction(_ action: @escaping () -> Void) -> Self {
        updateConfiguration { $0.action = action }
    }

    func setEnabled(_ isEnabled: Bool) -> Self {
        updateConfiguration { $0.isEnabled = isEnabled }
    }

    func setHeader(text: String?, color: Color? = nil, font: Font? = nil) -> Self {
        updateConfiguration {
            $0.headerText = text
            if let color { $0.headerColor = color }
            if let font { $0.headerFont = font }
        }
    }

    func setBackgroundColor(_ color: Color) -> Self {
        updateConfiguration { $0.backgroundColor = color }
    }

    func setFooter(text: String?, color: Color? = nil, font: Font? = nil, action: (() -> Void)? = nil) -> Self {
        updateConfiguration {
            $0.footerTextButton = text
            if let color { $0.footerTextColor = color }
            if let font { $0.footerTextFont = font }
            if let action { $0.footerTextActionButton = action }
        }
    }
}

struct ConfirmButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmButton(configuration: .init(title: "test", headerText: "123", footerTextButton: "123"))
    }
}
