//
//  EmotionAnalyser.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import Foundation

struct EmotionAnalyser: TextAnalyser {
    private let destructurer: TextDestructurer
    
    var labelPerSentence: [Emotion] {
        []
    }
    
    var labelPerParagraph: [Emotion] {
        []
    }
    
    var labelOverall: [Emotion] {
        []
    }
    
    init(_ text: String) {
        self.destructurer = TextDestructurer(text)
    }
}
