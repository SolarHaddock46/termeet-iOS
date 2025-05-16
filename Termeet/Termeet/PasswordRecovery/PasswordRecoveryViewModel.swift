//
//  PasswordRecoveryViewModel.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 16.05.2025.
//

import SwiftUI


final class PasswordRecoveryViewModel: ObservableObject {
    @Published var stateView: StateView = .inputEmail
    @Published var bindings = [String: String]()

    func getInputTextConfigurations() -> [InputTextConfiguration] {
        return []
    }
}

extension PasswordRecoveryViewModel {
    enum StateView {
        case inputEmail, sendingLetter, inputNewPassword
    }
}
