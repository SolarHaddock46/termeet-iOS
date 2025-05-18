//
//  PasswordRecoveryView.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI

private enum Constants {
    enum Fonts {

    }

    enum Sizes {

    }

    enum Layouts {
        
    }

    enum Texts {

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
                    Text("Восстановление пароля")
                        .font(.system(size: 30, weight: .bold))
                    Spacer()
                }.padding(.bottom, viewModel.stateView == .sendingLetter ? 0 : 48)
                VStack(spacing: 20) {
                    if viewModel.stateView == .sendingLetter {
                        Text(
                            "На адрес superpochta@mail.ru отправлено письмо с" +
                            " ссылкой для восстановления пароля. Пожалуйста, проверьте папку спам."
                        )
                    } else {
                        inputTextViews
                    }
                    Spacer()
                    ConfirmButton(configuration: viewModel.confirmButtonConfiguration)
                }
            }.padding(.leading, 16)
                .padding(.trailing, 16)
        }.onAppear {
            viewModel.injectRouter(router)
            viewModel.startCheckingAnswerEmail()
        }.onDisappear {
            viewModel.endCheckingAnswerEmail()
        }.navigationDestination(for: Route.self) { route in
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
        VStack(spacing: 24) {
            ForEach(viewModel.getContainers(), id: \.id) { id, container in
                InputTextView(text: viewModel.binding(for: id), configuration: container.configuration)
            }
            Spacer()
        }.padding(.leading, 16)
            .padding(.trailing, 16)

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
