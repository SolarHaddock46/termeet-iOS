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
    @StateObject var viewModel = PasswordRecoveryViewModel()

    var body: some View {
        inputTextViews
            .navigationTitle("Восстановление пароля")
            .navigationBarTitleDisplayMode(.automatic)
    }

    var inputTextViews: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.getContainers(), id: \.id) { id, container in
                InputTextView(text: viewModel.binding(for: id), configuration: container.configuration)
            }
            Spacer()
        }
    }
}

struct PasswordRecoveryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PasswordRecoveryView()
        }
    }
}
