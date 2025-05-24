//
//  PasswordRecoveryView.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI

private enum Constants {
    enum Fonts {
        static let recoveryTitle = Font.system(size: 30, weight: .bold)
    }

    enum Sizes {
        static let bottomPadding: CGFloat = 48
        static let spacingBetweenViews: CGFloat = 20
        static let horizontalPadding: CGFloat = 16
    }

    enum Layouts {
        static let inputViewsSpacing: CGFloat = 24
    }

    enum Texts {
        static let recoveryTitle = "Восстановление пароля"
        static let emailSentMessage = """
            На адрес superpochta@mail.ru отправлено письмо с \
            ссылкой для восстановления пароля. Пожалуйста, \
            проверьте папку спам.
            """
    }
}

struct PasswordRecoveryView: View {
    @StateObject var viewModel: PasswordRecoveryViewModel
    @EnvironmentObject var router: Router

    init(viewModel: PasswordRecoveryViewModel? = nil) {
        if let viewModel {
            _viewModel = StateObject(wrappedValue: viewModel)
        } else {
            _viewModel = StateObject(wrappedValue: .init())
        }
    }

    var body: some View {
        Group {
            VStack {
                HStack {
                    Text(Constants.Texts.recoveryTitle)
                        .font(Constants.Fonts.recoveryTitle)
                    Spacer()
                }
                .padding(.bottom, viewModel.stateView == .sendingLetter ? 0 : Constants.Sizes.bottomPadding)

                VStack(spacing: Constants.Sizes.spacingBetweenViews) {
                    if viewModel.stateView == .sendingLetter {
                        Text(Constants.Texts.emailSentMessage)
                    } else {
                        inputTextViews
                    }
                    Spacer()
                    ConfirmButton(configuration: viewModel.confirmButtonConfiguration)
                }
            }
            .padding(.horizontal, Constants.Sizes.horizontalPadding)
        }
        .onAppear {
            viewModel.injectRouter(router)
            viewModel.startCheckingAnswerEmail()
        }
        .onDisappear {
            viewModel.endCheckingAnswerEmail()
        }
        .navigationDestination(for: Route.self) { route in
            let destinationView: PasswordRecoveryView? = {
                switch route {
                case .passwordRecoverySendingLetter:
                    return PasswordRecoveryView(viewModel: .init(router: router, stateView: .sendingLetter))
                case .passwordRecoveryInputNewPassword:
                    return PasswordRecoveryView(viewModel: .init(router: router, stateView: .inputNewPassword))
                default:
                    return nil
                }
            }()
            destinationView
        }
    }

    var inputTextViews: some View {
        VStack(spacing: Constants.Layouts.inputViewsSpacing) {
            ForEach(viewModel.getContainers(), id: \.id) { id, container in
                InputTextView(text: viewModel.binding(for: id), configuration: container.configuration)
            }
            Spacer()
        }
        .padding(.horizontal, Constants.Sizes.horizontalPadding)
    }
}

struct PasswordRecoveryView_Previews: PreviewProvider {
    struct ContainerPreview: View {
        @StateObject private var router = Router()

        var body: some View {
            NavigationStack(path: $router.path) {
                PasswordRecoveryView()
            }.environmentObject(router)
        }
    }

    static var previews: some View {
        ContainerPreview()
    }
}
