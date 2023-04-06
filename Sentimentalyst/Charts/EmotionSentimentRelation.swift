//
//  EmotionSentimentRelation.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 05/04/2023.
//

import SwiftUI

struct EmotionSentimentRelation: View {
    var sentimentPerEmotion: [Emotion : SentimentScore]
    
    init(emotionPerSentence: [Emotion], sentimentPerSentence: [SentimentScore]) {
        self.sentimentPerEmotion = [:]
        
        // get indices for each emotion (may repeat so list)
        // e.g. sadness -> [3, 5, 7]
        var emotionIndices: [Emotion: [Int]] = [:]
        for emotion in Emotion.allCases {
            emotionIndices[emotion] = []
            for (index, e) in emotionPerSentence.enumerated() {
                if e == emotion {
                    emotionIndices[emotion]?.append(index)
                }
            }
        }
        
        for (emotion, vals) in emotionIndices {
            var total = 0
            for index in vals {
                total += sentimentPerSentence[index]
            }
            sentimentPerEmotion[emotion] = total / vals.count
        }
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct EmotionSentimentRelation_Previews: PreviewProvider {
    static var previews: some View {
        EmotionSentimentRelation(emotionPerSentence: emotions, sentimentPerSentence: sentiments)
            .frame(width: 500)
    }
    
    static var emotions: [Emotion] = [
        .joy,
        .joy,
        .anger,
        .love,
        .joy,
        .unknown,
        .fear,
        .love,
        .anger,
        .sadness,
        .joy
    ]
    
    static var sentiments = [
        60,
        80,
        -40,
        100,
        40,
        -20,
        -80,
        40,
        -60,
        -20,
        80,
    ]
}
