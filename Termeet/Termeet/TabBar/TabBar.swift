//
//  TabBar.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 01.05.2025.
//
import SwiftUI

struct TabBar<Content: View, Background: View, Item: Identifiable>: View {
    @Binding var selected: Item.ID
    private let items: [Item]
    private let content: (Item) -> Content
    private var axis: Axis.Set = .horizontal
    private var willSelect: ((_ old: Item, _ new: Item) -> Void)?
    private var didSelect: ((_ old: Item, _ new: Item) -> Void)?
    private var background: Background

    init(
        selected: Binding<Item.ID>,
        items: [Item],
        axis: Axis.Set = .horizontal,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder background: @escaping () -> Background = { EmptyView() }
    ) {
        self._selected = selected
        self.items = items
        self.content = content
        self.axis = axis
        self.background = background()
    }

    var body: some View {
        ZStack {
            self.background
            if axis == .horizontal {
                HStack {
                    tabButtons
                }
            } else {
                VStack {
                    tabButtons
                }
            }
        }
    }

    private var tabButtons: some View {
        ForEach(items, id: \.id) { item in
            Button {
                selected = item.id
            } label: {
                content(item)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

private enum Tags: Int, Hashable {
    case none, home, search
}

private struct PreviewTabItem: Identifiable {
    let id: Tags
}

#Preview {
    @Previewable @State var selected: Tags = .none
    TabBar(
        selected: $selected,
        items: [
            PreviewTabItem(id: .home),
            PreviewTabItem(id: .search)
        ]
    ) { item in
        ZStack {
            Rectangle()
                .foregroundStyle(selected == item.id ? .brown : .clear)
                .cornerRadius(10)
            Text("Tab \(item.id)")
                .foregroundStyle(selected == item.id ? .blue : .black)
        }
    } background: {
        Color.gray
            .cornerRadius(10)
            .shadow(radius: 3)
    }
    .frame(height: 50)
    .padding()
}
