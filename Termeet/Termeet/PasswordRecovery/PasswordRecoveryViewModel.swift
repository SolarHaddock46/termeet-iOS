//
//  PasswordRecoveryViewModel.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI
import OSLog

private class MockNetworkingService {
    func isCorrectEmail(_ email: String) -> Bool {
        email == "test@test.com"
    }
}

private enum ContainerUUIDs {
    enum InputEmail {
        static let email = UUID()
    }

    enum SendingLetter {}

    enum InputNewPassword {
        static let password = UUID()
        static let repeatPassword = UUID()
    }
}

final class PasswordRecoveryViewModel: ObservableObject {
    @Published private(set) var stateView: StateView = .inputEmail

    convenience init(copying other: PasswordRecoveryViewModel, state: StateView) {
        self.init()
        self.containers = other.containers
        self.stateView = state
      }

    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "Unknown",
        category: String(describing: PasswordRecoveryViewModel.self)
    )
    private let networkingService = MockNetworkingService()
    @Published private var containers = [UUID: Container]()

    init() {
        initContainers()
    }

    func binding(for id: UUID) -> Binding<String> {
        Binding(
            get: { self.containers[id]?.text ?? "" },
            set: { self.containers[id]?.text = $0 }
        )
    }

    func getContainer(for id: UUID) -> Container {
        guard let container = containers[id] else {
            logger.warning("Container not found for id: \(id)")
            return .init(configuration: .init())
        }
        return container
    }

    func getContainers() -> [(id: UUID, container: Container)] {
        let uuids = getContainerUUIDs()
        return uuids.map { uuid in
            (uuid, getContainer(for: uuid))
        }
    }

    private func getContainerUUIDs() -> [UUID] {
        return switch stateView {
        case .inputEmail:
            [ContainerUUIDs.InputEmail.email]
        case .sendingLetter:
            []
        case .inputNewPassword:
            [ContainerUUIDs.InputNewPassword.password, ContainerUUIDs.InputNewPassword.repeatPassword]
        }
    }

    private func initContainers() {
        containers[ContainerUUIDs.InputEmail.email] = .init(
            configuration: .init(
                placeholder: "Введите почту",
                headerText: "Почта",
                footerText: "На эту почту будет отправлено письмо с восстановлением",
                isSecured: true,
                onTextChange: {
                    self.checkEmail($0)
                },
            )
        )
        containers[ContainerUUIDs.InputNewPassword.password] = .init(configuration: .init())
        containers[ContainerUUIDs.InputNewPassword.repeatPassword] = .init(configuration: .init())
    }

    private func checkEmail(_ email: String) {
        if email == "123" {
            print("error email")
            containers[ContainerUUIDs.InputEmail.email]?.configuration.update {
                $0.isErrored = true
                $0.footerText = "Почта некорректна"
            }
        } else {
            print("no error email")
            containers[ContainerUUIDs.InputEmail.email]?.configuration.update {
                $0.isErrored = false
                $0.footerText = "На эту почту будет отправлено письмо с восстановлением"
            }
        }
    }
}

extension PasswordRecoveryViewModel {
    enum StateView: Hashable {
        case inputEmail, sendingLetter, inputNewPassword
    }
}

extension PasswordRecoveryViewModel {
    struct Container {
        var text: String = ""
        var configuration: InputTextConfiguration
    }
}

extension PasswordRecoveryViewModel {
    func setState(_ state: StateView) {
        self.stateView = state
    }
}

extension PasswordRecoveryViewModel {
    func nextState() {
        switch stateView {
        case .inputEmail:
            stateView = .sendingLetter
        case .sendingLetter:
            stateView = .inputNewPassword
        case .inputNewPassword:
            break
        }
    }

    func previousState() {
        switch stateView {
        case .inputNewPassword:
            stateView = .sendingLetter
        case .sendingLetter:
            stateView = .inputEmail
        case .inputEmail:
            break
        }
    }
}
