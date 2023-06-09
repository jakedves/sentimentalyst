//
//  Sentimentalyst.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import SwiftUI

typealias Sentiment = Double
typealias SentimentScore = Int

@main
struct Sentimentalyst: App {
    @AppStorage("needsOnboarding") private var needsOnboarding = true
    // prevent lazy init => thread error as init and setting a @Published value on non-main thread
    let processor = TextProcessor()
    
    var body: some Scene {
        WindowGroup {
            MainScreen(needsOnboarding: needsOnboarding)
                .environmentObject(processor)
        }
    }
}
