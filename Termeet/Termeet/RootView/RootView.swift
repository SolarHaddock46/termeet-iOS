//
//  RootView.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 03.05.2025.
//

import SwiftUI

private enum Constants {
    static let icons: [RootView.Icon] = [
        .init(id: .meets, nameImage: "line.3.horizontal"),
        .init(id: .teams, nameImage: "person.2.fill"),
        .init(id: .createMeet, nameImage: "plus.app"),
        .init(id: .notifications, nameImage: "person.fill"),
        .init(id: .profile, nameImage: "bell.fill")
    ]
    
    enum Colors {
        static let backgroundTabBar = Color.white
    }
}

struct RootView: View {
   enum Tab: Int {
        case meets, teams, createMeet, notifications, profile
    }

    struct Icon: Identifiable {
        let id: Tab
        let nameImage: String
    }

    @State var selectedTab: Tab = .profile

    var body: some View {
        VStack(spacing: 0) {
            tabContent(selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            TabBar(
                selected: $selectedTab,
                items: Constants.icons
            ) { item in
                Image(systemName: item.nameImage)
                    .foregroundStyle(selectedTab == item.id ? Color.blue : Color.black)
            } background: {
                Constants.Colors.backgroundTabBar
            }
            .frame(maxHeight: 84)
            .edgesIgnoringSafeArea(.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

private extension RootView {
    @ViewBuilder func tabContent(_ selectedTab: Tab) -> some View {
        switch selectedTab {
        case .createMeet: Text("Create Meet")
        case .meets: Text("Meets")
        case .notifications: Text("Notifications")
        case .profile: Text("Profile")
        case .teams: Text("Teams")
        }
    }
}
