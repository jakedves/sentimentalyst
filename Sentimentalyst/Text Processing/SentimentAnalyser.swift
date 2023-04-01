//
//  SentimentAnalyser.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import NaturalLanguage

struct SentimentAnalyser: TextAnalyser {
    typealias Sentiment = Double
    private let destructurer: TextDestructurer
    
    var labelPerSentence: [Sentiment] {
        destructurer.sentences.map(sentiment)
    }
    
    var labelPerParagraph: [Sentiment] {
        destructurer.paragraphs.map(sentiment)
    }
    
    var labelOverall: Sentiment {
        sentiment(for: destructurer.text)
    }
    
    init(_ text: String) {
        self.destructurer = TextDestructurer(text)
    }
    
    func sentiment(for text: String) -> Double {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .document, scheme: .sentimentScore)
        return Double(sentiment?.rawValue ?? "0") ?? 0
    }
}
