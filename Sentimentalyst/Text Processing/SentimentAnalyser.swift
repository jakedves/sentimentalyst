//
//  SentimentAnalyser.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import Foundation

struct SentimentAnalyser: TextAnalyser {
    typealias Sentiment = Float
    private let destructurer: TextDestructurer
    
    
    var labelPerSentence: [Sentiment] {
        []
    }
    
    var labelPerParagraph: [Sentiment] {
        []
    }
    
    var labelOverall: [Sentiment] {
        []
    }
    
    init(_ text: String) {
        self.destructurer = TextDestructurer(text)
    }
}
