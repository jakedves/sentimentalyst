//
//  SentimentAnalyser.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import NaturalLanguage

struct SentimentAnalyser: TextAnalyser {
    private let destructurer: TextDestructurer
    
    var labelPerSentence: [Sentiment] {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        let text = destructurer.text
        tagger.string = text
        
        let tags = tagger.tags(in: text.startIndex..<text.endIndex, unit: .sentence, scheme: .sentimentScore)
        return tags.map({ tag in
            Double(tag.0?.rawValue ?? "0") ?? 0
        })
    }
    
    var labelOverall: Sentiment {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        let text = destructurer.text
        tagger.string = text
        
        let tag = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        return Double(tag.0?.rawValue ?? "0") ?? 0
    }
    
    init(_ text: String) {
        self.destructurer = TextDestructurer(text)
    }
}
