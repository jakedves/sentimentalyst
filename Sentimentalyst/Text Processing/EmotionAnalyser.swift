//
//  EmotionAnalyser.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 01/04/2023.
//

import CoreML
import NaturalLanguage

struct EmotionAnalyser: TextAnalyser {
    private let destructurer: TextDestructurer
    private let emotionClassifier: NLModel
    
    var labelPerSentence: [Emotion] {
        emotions(from: destructurer.sentences)
    }
    
    var labelOverall: Emotion {
        emotion(for: destructurer.text)
    }
    
    // failable init => useless without the model
    init?(_ text: String) {
        self.destructurer = TextDestructurer(text)
        
        do {
            let config = MLModelConfiguration()
            let ml = try TextClassifier(configuration: config).model
            self.emotionClassifier = try NLModel(mlModel: ml)
        } catch {
            print(error)
            return nil
        }
    }
    
    private func emotions(from list: [String]) -> [Emotion] {
        return list.map(emotion)
    }
    
    private func emotion(for value: String) -> Emotion {
        Emotion(rawValue: emotionClassifier.predictedLabel(for: value) ?? "unknown") ?? .unknown
    }
}
