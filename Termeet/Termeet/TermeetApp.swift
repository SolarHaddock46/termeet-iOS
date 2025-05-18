//
//  TermeetApp.swift
//  Termeet
//
//  Created by Владимир Мацнев on 30.04.2025.
//

import SwiftUI

@main
struct TermeetApp: App {
    @StateObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                PasswordRecoveryView()
            }.environmentObject(router)
        }
    }
}
