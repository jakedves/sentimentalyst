//
//  EmotionPrevalence.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI
import Charts

struct EmotionPrevalence: View {
    private let weights: [Emotion: Int]
    
    init(weights: [Emotion: Int]) {
        self.weights = weights
    }
    
    var body: some View {
        VStack {
            Text(Constants.title)
                .bold()
                .font(.title2)
            Chart {
                ForEach(Emotion.allCases) { emotion in
                    BarMark(x: .value(Constants.xLabel, emotion.rawValue.capitalized),
                            y: .value(Constants.yLabel, weights[emotion] ?? 0)
                    )
                    .foregroundStyle(emotionToColor[emotion] ?? .black)
                }
            }
            .chartYAxisLabel(Constants.yAxisLabel)
        }
    }
    
    struct Constants {
        static let title = "Emotion Prevalence"
        static let xLabel = "Emotion"
        static let yLabel = "Percentage"
        static let yAxisLabel = "Percentage of Sentences (%)"
    }
}

struct EmotionPrevalence_Previews: PreviewProvider {
    static var previews: some View {
        EmotionPrevalence(weights: [:])
    }
}
