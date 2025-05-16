//
//  InputTextView.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI

private enum Constants {
    enum Icons {
        static let showTextButton = "eyeDefault"
        static let hideTextButton = "eyeHidden"
        static let iconSize: CGFloat = 20
    }

    enum Fonts {
        static let header = Font.system(size: 17, weight: .regular)
        static let textField = Font.system(size: 17, weight: .regular)
        static let footer = Font.system(size: 13, weight: .regular)
        static let auxiliaryButton = Font.system(size: 17, weight: .regular)
    }

    enum Colors {
        static let error = Color(light: .init(hex: 0xFC3F1D), dark: .init(hex: 0xFC3F1D))
        static let border = Color(light: .init(hex: 0x2F2F2F), dark: .init(hex: 0x2F2F2F))
        static let header = Color(light: .init(hex: 0x2F2F2F), dark: .init(hex: 0x2F2F2F))
        static let footer = Color(light: .init(hex: 0x959595), dark: .init(hex: 0x959595))
    }

    enum Layouts {
        static let cornerRadius: CGFloat = 10
        static let textFieldPadding = EdgeInsets(top: 12.5, leading: 12, bottom: 12.5, trailing: 12)
        static let elementSpacing: CGFloat = 8
        static let footerPadding: CGFloat = 4
    }
}

struct InputTextConfiguration {
    var placeholder: String?
    var headerText: String?
    var footerText: String?
    var auxiliaryButtonText: String?

    var isSecured: Bool = false
    var isErrored: Bool = false

    var headerFont: Font = Constants.Fonts.header
    var headerColor: Color = Constants.Colors.header
    var footerFont: Font = Constants.Fonts.footer
    var footerColor: Color = Constants.Colors.footer
    var errorColor: Color = Constants.Colors.error
    var boardColor: Color = Constants.Colors.border

    var onBeginEditing: (() -> Void)?
    var onEndEditing: (() -> Void)?
    var onTextChange: ((String) -> Void)?
    var auxiliaryButtonAction: (() -> Void)?

    mutating func update(_ changes: (inout Self) -> Void) {
        changes(&self)
    }

}

struct InputTextView: View {
    @Binding var text: String
    @State private var isShowingText: Bool = false
    private var configuration: InputTextConfiguration

    init(text: Binding<String>, configuration: InputTextConfiguration = InputTextConfiguration()) {
        self._text = text
        self.configuration = configuration
    }

    var body: some View {
        VStack(spacing: Constants.Layouts.elementSpacing) {
            headerView
            textFieldView
            footerView
        }
    }
}

// MARK: - Subviews
private extension InputTextView {
    var headerView: some View {
        HStack {
            if let headerText = configuration.headerText {
                Text(headerText)
                    .font(configuration.headerFont)
                    .foregroundColor(configuration.headerColor)
            }
            Spacer()
        }
    }

    var textFieldView: some View {
        HStack {
            textField
            secureToggleButton
        }
        .padding(Constants.Layouts.textFieldPadding)
        .background(
            RoundedRectangle(cornerRadius: Constants.Layouts.cornerRadius)
                .stroke(
                    configuration.isErrored ?
                    configuration.errorColor :
                    (text.isEmpty ? configuration.footerColor : configuration.boardColor),
                    lineWidth: 1
                )
        )
    }

    var footerView: some View {
        HStack {
            if let footerText = configuration.footerText {
                Text(footerText)
                    .font(configuration.footerFont)
                    .foregroundColor(configuration.isErrored ?
                                   configuration.errorColor :
                                   configuration.footerColor)
            }
            Spacer()
            auxiliaryButton
        }
    }

    var textField: some View {
        Group {
            if configuration.isSecured && !isShowingText {
                SecureField(
                    configuration.placeholder ?? "",
                    text: $text,
                    onCommit: { configuration.onEndEditing?() }
                )
            } else {
                TextField(
                    configuration.placeholder ?? "",
                    text: $text,
                    onEditingChanged: { isEditing in
                        isEditing ?
                        configuration.onBeginEditing?() :
                        configuration.onEndEditing?()
                    }
                )
            }
        }
        .font(Constants.Fonts.textField)
        .onChange(of: text) { newValue in
            configuration.onTextChange?(newValue)
        }
    }

    var secureToggleButton: some View {
        Group {
            if configuration.isSecured {
                Image(isShowingText ? Constants.Icons.hideTextButton : Constants.Icons.showTextButton)
                    .resizable()
                    .frame(
                        maxWidth: Constants.Icons.iconSize,
                        maxHeight: Constants.Icons.iconSize
                    )
                    .onTapGesture {
                        isShowingText.toggle()
                    }
            }
        }
    }

    var auxiliaryButton: some View {
        Group {
            if let auxiliaryButtonText = configuration.auxiliaryButtonText {
                Button(action: configuration.auxiliaryButtonAction ?? {}) {
                    Text(auxiliaryButtonText)
                        .font(Constants.Fonts.auxiliaryButton)
                }
            }
        }
    }
}

// MARK: - Modifiers
extension InputTextView {
    func setConfiguration(_ value: InputTextConfiguration) -> Self {
        var view = self
        view.configuration = value
        return view
    }

    func updateConfiguration(_ update: (inout InputTextConfiguration) -> Void) -> Self {
        var view = self
        view.configuration.update(update)
        return view
    }

    func setPlaceholder(_ value: String) -> Self {
        updateConfiguration { $0.placeholder = value }
    }

    func setHeader(text: String? = nil, font: Font? = nil, color: Color? = nil) -> Self {
        updateConfiguration {
            if let text { $0.headerText = text }
            if let font { $0.headerFont = font }
            if let color { $0.headerColor = color }
        }
    }

    func setFooter(text: String? = nil, font: Font? = nil, color: Color? = nil) -> Self {
        updateConfiguration {
            if let text { $0.footerText = text }
            if let font { $0.footerFont = font }
            if let color { $0.footerColor = color }
        }
    }

    func setErrorState(_ value: Bool) -> Self {
        updateConfiguration { $0.isErrored = value }
    }

    func setSecureInput(_ value: Bool) -> Self {
        updateConfiguration { $0.isSecured = value }
    }

    func setBoardColor(_ value: Color) -> Self {
        updateConfiguration { $0.boardColor = value }
    }

    func setAuxiliaryButton(text: String, action: @escaping () -> Void) -> Self {
        updateConfiguration {
            $0.auxiliaryButtonText = text
            $0.auxiliaryButtonAction = action
        }
    }

    func setOnBeginEditing(_ action: @escaping () -> Void) -> Self {
        updateConfiguration { $0.onBeginEditing = action }
    }

    func setOnEndEditing(_ action: @escaping () -> Void) -> Self {
        updateConfiguration { $0.onEndEditing = action }
    }

    func setOnTextChange(_ action: @escaping (String) -> Void) -> Self {
        updateConfiguration { $0.onTextChange = action }
    }
}

struct InputTextView_Previews: PreviewProvider {
    static var previews: some View {
        InputTextView(text: .constant(""))
            .setHeader(text: "Пароль")
            .setFooter(text: "Минимум 8 символов")
            .setPlaceholder("Введите пароль")
            .setSecureInput(true)
            .setAuxiliaryButton(text: "Забыли пароль?") {
                print("Кнопка нажата")
            }
    }
}
