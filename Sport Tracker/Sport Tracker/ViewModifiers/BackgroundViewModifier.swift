//
//  BackgroundViewModifier.swift
//  Sport Tracker
//
//  Created by ipraktikum on 10.10.24.
//

import SwiftUI

// MARK: - BackgroundViewModifier
/// A `ViewModifier` to style a `View` with a system background color
private struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

private struct CardViewModifier: ViewModifier {
    var backgroundColor = Color("CardColor")
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, minHeight: 150, alignment: .center)
            .background(.background.secondary)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

// MARK: - View + BackgroundViewModifier
extension View {
    /// Style a `View` with a grouped system background color
    /// - Returns: A view with the applied background
    func backgroundViewModifier() -> some View {
        ModifiedContent(content: self, modifier: BackgroundViewModifier())
    }

    func cardViewModifier() -> some View {
        ModifiedContent(content: self, modifier: CardViewModifier())
    }
}
