//
//  EmotionUI.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import SwiftUI

let EmotionColor: [Emotion : Color] = [
    .joy : .green,
    .anger : .red,
    .sadness : .blue,
    .fear : .gray,
    .love : .pink,
    .unknown : .orange
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
