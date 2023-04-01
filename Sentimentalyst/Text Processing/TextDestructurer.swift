//
//  TextDestructurer.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import NaturalLanguage

struct TextDestructurer {
    private let text: String
    private var content: [NLTokenUnit : [String]]
    
    public var words: [String] {
        self.content[.word]!
    }
    
    public var sentences: [String] {
        self.content[.sentence]!
    }
    
    public var paragraphs: [String] {
        self.content[.paragraph]!
    }
    
    init(_ text: String) {
        self.text = text
        let wordTokenizer = NLTokenizer(unit: .word)
        let sentenceTokenizer = NLTokenizer(unit: .sentence)
        let paragraphTokenizer = NLTokenizer(unit: .paragraph)
        
        let tokenizers = [wordTokenizer, sentenceTokenizer, paragraphTokenizer]
        tokenizers.forEach({ $0.string = text })
        
        self.content = [:]
        
        tokenizers.forEach({ tokenizer in
            content[tokenizer.unit] = tokenize(tokenizer)
        })
    }
    
    private func tokenize(_ tokenizer: NLTokenizer) -> [String] {
        return tokenizer.tokens(for: text.startIndex..<text.endIndex).map({ String(text[$0]) })
    }
}
