//
//  Sentimentalyst.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import SwiftUI

typealias Sentiment = Double

@main
struct Sentimentalyst: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environmentObject(TextProcessor())
        }
    }
}
