//
//  HelpImage.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI

struct HelpImage<Content: View>: View {
    @State private var popoverPresented = false
    private let content: () -> Content
    private let iconName = "questionmark.circle"
    
    init(onHelp: @escaping () -> Content = EmptyView.init) {
        self.content = onHelp
    }
    
    var body: some View {
        Button(action: { popoverPresented.toggle() }) {
            Image(systemName: iconName)
                .bold(false)
        }
        .popover(isPresented: $popoverPresented) {
            content()
                .fixedSize(horizontal: false, vertical: true)
                .frame(minWidth: 0,
                       minHeight: 0)
                .padding(30)
        }
        .animation(.easeInOut, value: popoverPresented)
    }
}

struct HelpImage_Previews: PreviewProvider {
    static var previews: some View {
        HelpImage()
    }
}
