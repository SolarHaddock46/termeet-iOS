//
//  PasswordRecoveryView.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI

private enum Constants {

}

struct PasswordRecoveryView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel = PasswordRecoveryViewModel()

    init(viewModel: PasswordRecoveryViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        inputTextViews
    }

    var inputTextViews: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.getContainers(), id: \.id) { id, container in
                InputTextView(text: viewModel.binding(for: id), configuration: container.configuration)
            }
            Spacer()
        }.navigationDestination(for: Route.self) { route in
            let destinationView: PasswordRecoveryView? = {
                switch route {
                case .passwordRecoverySendingLetter:
                    let childVM = PasswordRecoveryViewModel(
                        copying: self.viewModel,
                        state: .sendingLetter
                    )
                    return PasswordRecoveryView(viewModel: childVM)
                case .passwordRecoveryInputNewPassword:
                    let childVM = PasswordRecoveryViewModel(
                        copying: self.viewModel,
                        state: .inputNewPassword
                    )
                    return PasswordRecoveryView(viewModel: childVM)
                default:
                    return nil
                }
            }()
            Group {
                destinationView
            }
            .onDisappear {
                switch route {
                case .passwordRecoverySendingLetter:
                    viewModel.setState(.inputEmail)
                case .passwordRecoveryInputNewPassword:
                    viewModel.setState(.sendingLetter)
                default:
                    break
                }
            }
        }
    }
}

struct PasswordRecoveryView_Previews: PreviewProvider {
    struct ContainerPreview: View {
        @StateObject private var router = Router()

        var body: some View {
            NavigationStack(path: $router.path) {
                PasswordRecoveryView()
                    .navigationTitle("Восстановление пароля")
                    .navigationBarTitleDisplayMode(.automatic)
            }.environmentObject(router)
        }
    }

    static var previews: some View {
        ContainerPreview()
    }
}
