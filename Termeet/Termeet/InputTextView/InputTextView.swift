//
//  InputTextView.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI
import Combine

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

struct InputTextView: View {
    @Binding var text: String
    @State private var isShowingText: Bool = false

    private var placeholder: String?
    private var headerText: String?
    private var footerText: String?
    private var auxiliaryButtonText: String?

    private var isSecured: Bool = false
    private var isErrored: Bool = false

    private var headerFont: Font = Constants.Fonts.header
    private var headerColor: Color = Constants.Colors.header
    private var footerFont: Font = Constants.Fonts.footer
    private var footerColor: Color = Constants.Colors.footer
    private var errorColor: Color = Constants.Colors.error
    private var boardColor: Color = Constants.Colors.border

    private var onBeginEditing: (() -> Void)?
    private var onEndEditing: (() -> Void)?
    private var onTextChange: ((String) -> Void)?
    private var auxiliaryButtonAction: (() -> Void)?

    init(text: Binding<String>, headerText: String? = nil, footerText: String? = nil) {
        self._text = text
        self.headerText = headerText
        self.footerText = footerText
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
            if let headerText {
                Text(headerText)
                    .font(headerFont)
                    .foregroundColor(headerColor)
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
                .stroke(isErrored ? errorColor : boardColor, lineWidth: 1)
        )
    }

    var footerView: some View {
        HStack {
            if let footerText {
                Text(footerText)
                    .font(footerFont)
                    .foregroundColor(isErrored ? errorColor : footerColor)
            }
            Spacer()
            auxiliaryButton
        }
    }

    var textField: some View {
        Group {
            if isSecured && !isShowingText {
                SecureField(
                    placeholder ?? "",
                    text: $text,
                    onCommit: { onEndEditing?() }
                )
            } else {
                TextField(
                    placeholder ?? "",
                    text: $text,
                    onEditingChanged: { isEditing in
                        isEditing ? onBeginEditing?() : onEndEditing?()
                    }
                )
            }
        }
        .font(Constants.Fonts.textField)
        .onChange(of: text) { newValue in
            onTextChange?(newValue)
        }
    }

    var secureToggleButton: some View {
        Group {
            if isSecured {
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
            if let auxiliaryButtonText {
                Button(action: auxiliaryButtonAction ?? {}) {
                    Text(auxiliaryButtonText)
                        .font(Constants.Fonts.auxiliaryButton)
                }
            }
        }
    }
}

// MARK: - Modifiers
extension InputTextView {
    func setPlaceholder(_ value: String) -> Self {
        var view = self
        view.placeholder = value
        return view
    }

    func setHeaderText(_ value: String?) -> Self {
        var view = self
        view.headerText = value
        return view
    }

    func setFooterText(_ value: String?) -> Self {
        var view = self
        view.footerText = value
        return view
    }

    func setHeaderFont(_ value: Font) -> Self {
        var view = self
        view.headerFont = value
        return view
    }

    func setHeaderColor(_ value: Color) -> Self {
        var view = self
        view.headerColor = value
        return view
    }

    func setFooterFont(_ value: Font) -> Self {
        var view = self
        view.footerFont = value
        return view
    }

    func setFooterColor(_ value: Color) -> Self {
        var view = self
        view.footerColor = value
        return view
    }

    func setErrorState(_ value: Bool) -> Self {
        var view = self
        view.isErrored = value
        return view
    }

    func setSecureInput(_ value: Bool) -> Self {
        var view = self
        view.isSecured = value
        return view
    }

    func setBoardColor(_ value: Color) -> Self {
        var view = self
        view.boardColor = value
        return view
    }

    func setAuxiliaryButton(text: String, action: @escaping () -> Void) -> Self {
        var view = self
        view.auxiliaryButtonText = text
        view.auxiliaryButtonAction = action
        return view
    }

    func setOnBeginEditing(_ action: @escaping () -> Void) -> Self {
        var view = self
        view.onBeginEditing = action
        return view
    }

    func setOnEndEditing(_ action: @escaping () -> Void) -> Self {
        var view = self
        view.onEndEditing = action
        return view
    }

    func setOnTextChange(_ action: @escaping (String) -> Void) -> Self {
        var view = self
        view.onTextChange = action
        return view
    }
}

struct InputTextViewPreview: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        InputTextView(text: $text)
            .setHeaderText("Test")
            .setFooterText("Text")
            .setPlaceholder("Test")
            .setSecureInput(false)
            .setAuxiliaryButton(text: "Password", action: {})
            .setErrorState(true)
            .padding()
    }
}
