//
//  TabBar.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 01.05.2025.
//
import SwiftUI

private struct LazyView<Content: View>: View {
    let build: () -> Content
    init(@ViewBuilder _ build: @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

/**
 A customizable and reusable tab bar component that supports full visual customization,
 animations, and flexible layout (horizontal or vertical).

 -  Parameters:
    - Content: The type of content view shown for each tab item.
    - Background: The type of background view behind the tab bar.
    - Item: The model used for each tab, must conform to Identifiable.
*/
struct TabBar<Content: View, Background: View, Item: Identifiable>: View {
    @Binding var selected: Item.ID
    private let items: [Item]
    private let content: (Item) -> Content
    private var axis: Axis.Set = .horizontal
    private var background: Background
    private var animationSelect: Animation?

    /**
     Creates a new TabBar.
     
     - Parameters:
         - selected: A binding to the selected item's ID.
         - items: An array of items to be displayed.
         - axis: The layout axis. Default is horizontal.
         - content: A view builder that returns content for each item.
         - background: A view builder for the background. Default is EmptyView.
    */
    init(
        selected: Binding<Item.ID>,
        items: [Item],
        axis: Axis.Set = .horizontal,
        @ViewBuilder content: @escaping (Item) -> Content,
        @ViewBuilder background: @escaping () -> Background = { EmptyView() }
    ) {
        precondition(!items.isEmpty, "TabBar must have at least one item")
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
                withAnimation(animationSelect) {
                    selected = item.id
                }
            } label: {
                LazyView {
                    content(item)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
            }
            .buttonStyle(.plain)
            .id(item.id)
        }
    }
}

// MARK: - Modifier

extension TabBar {
    /**
     Sets the animation to use when changing the selected tab.
     
     - Parameter animation: A closure returning the desired Animation.
     - Returns: A modified TabBar with the specified animation.
    */
    func onAnimationSelect(_ animation: () -> (Animation?)) -> Self {
        var copy = self
        copy.animationSelect = animation()
        return copy
    }
}
