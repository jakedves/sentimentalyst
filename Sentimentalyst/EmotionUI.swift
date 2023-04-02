//
//  EmotionUI.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import SwiftUI

let emotionToColor: [Emotion: Color] = [
    .joy : .green,
    .anger : .red,
    .sadness : .blue,
    .fear : .gray,
    .love : .purple.opacity(0.7),
    .unknown : .orange
]

let emotionToEmoji: [Emotion: String] = [
    .joy : "🤩",
    .anger : "😡",
    .sadness : "😔",
    .fear : "😰",
    .love : "🥰",
    .unknown : "🤨"
]

let emotionTip: [Emotion: String] = [
    .joy : "What a great day to journal about!",
    .anger : "You're a little angry, don't let anything bother you!",
    .sadness : "Don't be sad, tomorrow will be better!",
    .fear : "Don't worry about anything, you can get through this!",
    .love : "Love is in the air...",
    .unknown : "You were feeling a bit of everything today!"
]

// 5 categories: awful, bad, neutral, good, amazing
// possible values of sentiment: -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1
// 11 values => 2 values per category, 3 for good
func sentimentColor(_ sentiment: Sentiment) -> Color {
    if sentiment < -0.6 { // -1, -0.8
        return .red
    } else if sentiment < -0.2 { // -0.6, -0.4
        return .orange
    } else if sentiment < 0.2 { // -0.2, 0
        return .yellow
    } else if sentiment < 0.7 { // -0.2, 0.4, 0.6
        return .green.opacity(0.6)
    } else {
        return .green
    }
}

func sentimentLabel(_ sentiment: Sentiment) -> String {
    return ""
}
