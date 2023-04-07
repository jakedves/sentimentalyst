//
//  EmotionSentimentRelation.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 05/04/2023.
//

import SwiftUI
import Charts

struct EmotionSentimentRelation: View {
    @State private var showingPopover = false
    @State private var focusedColumn: String? = nil
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
        VStack {
            HStack {
                Text(Constants.title)
                    .lineLimit(1)
                    .bold()
                    .font(.title2)
                HelpImage() {
                    Text("Press and hold to see averages")
                }
            }
            Chart {
                ForEach(Emotion.allCases) { emotion in
                    let value = emotion.rawValue.capitalized
                    BarMark(x: .value(Constants.xLabel, value),
                            y: .value(Constants.yLabel, sentimentPerEmotion[emotion] ?? 0)
                    )
                    .foregroundStyle(emotionToColor[emotion]?
                        .opacity(focusedColumn == nil || focusedColumn == value ? 1.0 : 0.5) ?? .black)
                }
            }
            .chartYAxisLabel(Constants.yLabel)
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { val in
                                let x = val.location.x - geo[proxy.plotAreaFrame].origin.x
                                if let emotion: String = proxy.value(atX: x) {
                                    focusedColumn = emotion
                                    showingPopover = true
                                }
                            }
                            .onEnded { val in
                                focusedColumn = nil
                                showingPopover = false
                            }
                        )
                }
            }
            .popover(isPresented: $showingPopover) {
                Text("Your average sentiment was \(sentimentPerEmotion[Emotion(rawValue: focusedColumn?.lowercased() ?? "") ?? .joy] ?? 0) for \(focusedColumn ?? "")")
                    .padding([.horizontal], 15)
            }
        }
    }
    
    struct Constants {
        static let title = "Sentiment per Emotion"
        static let xLabel = "Emotion"
        static let yLabel = "Sentiment"
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
