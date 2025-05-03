//
//  TabBar.swift
//  Termeet
//
//  Created by Daniil Sukhanov on 01.05.2025.
//
import SwiftUI

/**
 A customizable and reusable tab bar component that supports full visual customization,
 animations, and flexible layout (horizontal or vertical).

 -  Parameters:
    - Content: The type of content view shown for each tab item.
    - Background: The type of background view behind the tab bar.
    - Item: The model used for each tab, must conform to Identifiable.

 This component allows:
 - Custom content for each tab.
 - Custom background.
 - Optional animation for selection changes.
 - Horizontal or vertical layout.
 ## Example Usage
 ```swift
 private enum Tags: Int, Hashable {
     case none, home, search
 }

 private struct PreviewTabItem: Identifiable {
     let id: Tags
 }

 @ViewBuilder private func content(_ tag: Tags) -> some View {
     switch tag {
     case .none:
         Text("CHOOSE!!!")
     case .home:
         Text("HOME!!!")
     case .search:
         Text("SEARCH!!!")
     }
 }

 #Preview {
     @Previewable @State var selected: Tags = .none
     ZStack(alignment: .bottom) {
         content(selected)
             .frame(maxWidth: .infinity, maxHeight: .infinity)
             .padding(.bottom, 60)
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
         .onAnimationSelect { .default }
         .frame(height: 80)
     }
     .frame(maxWidth: .infinity, maxHeight: .infinity)
     .edgesIgnoringSafeArea(.bottom)
 }
 ```
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
                content(item)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
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

#if DEBUG

private enum Tags: Int, Hashable {
    case none, home, search
}

private struct PreviewTabItem: Identifiable {
    let id: Tags
}

@ViewBuilder private func content(_ tag: Tags) -> some View {
    switch tag {
    case .none:
        Text("CHOOSE!!!")
    case .home:
        Text("HOME!!!")
    case .search:
        Text("SEARCH!!!")
    }
}

#Preview {
    @Previewable @State var selected: Tags = .none
    ZStack(alignment: .bottom) {
        content(selected)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 60)
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
        .onAnimationSelect { .default }
        .frame(height: 80)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .edgesIgnoringSafeArea(.bottom)
}

#endif
