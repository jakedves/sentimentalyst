//
//  SentimentPerSentence.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI
import Charts

struct SentimentPerSentence: View {
    private let data: [SentimentScore]
    private let avg: SentimentScore
    
    init(_ data: [SentimentScore], avg: SentimentScore) {
        self.data = data
        self.avg = avg
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.title)
                HelpImage() {
                    Text(Constants.explainer)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .frame(width: 400)
                }
            }
            .bold()
            .font(.title2)
            Chart {
                ForEach(data.indices, id: \.self) { index in
                    let sentiment = data[index]
                    LineMark(x: .value(Constants.xLabel, index + 1),
                            y: .value(Constants.yLabel, sentiment)
                    )
                    .interpolationMethod(.catmullRom)
                }
                RuleMark(y: .value("Average", avg))
                    .foregroundStyle(SentimentPerSentence.ruleColor(avg))
            }
            .chartYAxisLabel(Constants.yAxisTop, position: .top, alignment: .trailing)
            .chartYAxisLabel(Constants.yAxisBot, position: .bottom, alignment: .trailing)
            .chartXAxisLabel(Constants.xAxisLabel, position: .bottom, alignment: .center)
        }
    }
    
    private static func ruleColor(_ val: SentimentScore) -> Color {
        if val > 25 {
            return Color.green
        } else if val > -25 {
            return Color.gray
        } else {
            return Color.red
        }
    }
    
    struct Constants {
        static let title = "Sentiment"
        static let explainer = "Sentiment describes how positive your message is. A score close to 100 is very positive, whilst a score close to -100 is very negative."
        static let xLabel = "Sentence"
        static let yLabel = "Percentage"
        static let xAxisLabel = "Sentence Number"
        static let yAxisTop = "Positive"
        static let yAxisBot = "Negative"
    }
}

struct SentimentPerSentence_Previews: PreviewProvider {
    static var previews: some View {
        SentimentPerSentence([
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
        ], avg: 23)
        .frame(width: 500, height: 500 / 4 * 3)
    }
}
