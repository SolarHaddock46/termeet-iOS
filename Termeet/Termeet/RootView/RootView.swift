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

    enum Size {
        static let heightImageTabBar: CGFloat = 40
        static let widthImageTabBar: CGFloat = 40
        static let heightTabBar: CGFloat = 84
    }

    enum Colors {
        static let backgroundTabBar = Color(light: .init(hex: 0xFFFFFF), dark: .init(hex: 0xFFFFFF))
        static let selectedTab = Color(light: .init(hex: 0x386DD4), dark: .init(hex: 0x386DD4))
        static let unselectedTab = Color(light: .init(hex: 0x959595), dark: .init(hex: 0x959595))
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
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        maxWidth: Constants.Size.heightImageTabBar,
                        maxHeight: Constants.Size.widthImageTabBar
                    )
                    .foregroundStyle(
                        selectedTab == item.id ? Constants.Colors.selectedTab : Constants.Colors.unselectedTab
                    )
            } background: {
                Constants.Colors.backgroundTabBar
            }
            .frame(maxHeight: Constants.Size.heightTabBar)
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
