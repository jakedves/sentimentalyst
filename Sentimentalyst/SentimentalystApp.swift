//
//  SentimentalystApp.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import SwiftUI

@main
struct SentimentalystApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}

struct Previews_SentimentalystApp_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
