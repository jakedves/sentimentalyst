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
    @State private var averageOpacity = 0.5
    @State private var mainLineOpacity = 1.0
    
    init(_ data: [SentimentScore], avg: SentimentScore) {
        self.data = data
        self.avg = avg
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.title)
                    .bold()
                    .font(.title2)
                HelpImage() {
                    Text(Constants.explainer)
                        .multilineTextAlignment(.center)
                        .frame(width: 400)
                }
            }
            Chart {
                ForEach(data.indices, id: \.self) { index in
                    let sentiment = data[index]
                    LineMark(x: .value(Constants.xLabel, index + 1),
                            y: .value(Constants.yLabel, sentiment)
                    )
                    .interpolationMethod(.catmullRom)
                    .opacity(mainLineOpacity)
                    PointMark(x: .value(Constants.xLabel, index + 1),
                            y: .value(Constants.yLabel, sentiment)
                    )
                    .symbol(.cross)
                }
                RuleMark(y: .value("Average", avg))
                    .annotation(position: .top, alignment: .leading) {
                        Text("Average: \(avg, format: .number)")
                            .font(.headline)
                            .foregroundColor(SentimentPerSentence.ruleColor(avg))
                            .padding([.horizontal], 8)
                            .opacity(averageOpacity)
                    }
                    .foregroundStyle(SentimentPerSentence.ruleColor(avg))
                    .opacity(averageOpacity)
            }
            .chartYAxisLabel(Constants.yAxisTop, position: .top, alignment: .trailing)
            .chartYAxisLabel(Constants.yAxisBot, position: .bottom, alignment: .trailing)
            .chartXAxisLabel(Constants.xAxisLabel, position: .bottom, alignment: .center)
            .chartBackground { proxy in
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.green)
                            .frame(width: proxy.plotAreaSize.width, height: proxy.plotAreaSize.height / 2)
                            .offset(x: geo[proxy.plotAreaFrame].origin.x,
                                    y: geo[proxy.plotAreaFrame].origin.y)
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: proxy.plotAreaSize.width, height: proxy.plotAreaSize.height / 2)
                            .offset(x: geo[proxy.plotAreaFrame].origin.x,
                                    y: geo[proxy.plotAreaFrame].origin.y)
                    }
                    .opacity(0.1)
                    
                }
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    averageOpacity = 1.0
                    mainLineOpacity = 0.3
                }
                .onEnded { _ in
                    averageOpacity = 0.3
                    mainLineOpacity = 1.0
                }
            )
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
        static let explainer = "Sentiment describes how positive your message is. A score close to 100 is very positive, whilst a score close to -100 is very negative.\n\nLong press to see average"
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
