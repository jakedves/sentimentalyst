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
    @State private var focusedColumn: String? = nil
    @State private var showingPopover = false
    
    init(weights: [Emotion: Int]) {
        self.weights = weights
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.title)
                    .bold()
                    .font(.title2)
                HelpImage() {
                    Text("Press and hold to see percentages")
                }
            }
            Chart {
                ForEach(Emotion.allCases) { emotion in
                    let value = emotion.rawValue.capitalized
                    BarMark(x: .value(Constants.xLabel, value),
                            y: .value(Constants.yLabel, weights[emotion] ?? 0)
                    )
                    .foregroundStyle(emotionToColor[emotion]?
                        .opacity(focusedColumn == nil || focusedColumn == value ? 1.0 : 0.5) ?? .black)
                }
            }
            .chartYAxisLabel(Constants.yAxisLabel)
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
                Text("\(focusedColumn ?? "") showed up in \(weights[Emotion(rawValue: focusedColumn?.lowercased() ?? "") ?? .unknown] ?? 0)% of your sentences")
                    .padding([.horizontal], 15)
            }
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
        EmotionPrevalence(weights: [
            .unknown : Int(1.0 / 11.0 * 100.0),
            .joy: Int(4.0 / 11.0 * 100.0),
            .anger: Int(2.0 / 11.0 * 100.0),
            .sadness: Int(1.0 / 11.0 * 100.0),
            .love: Int(2.0 / 11.0 * 100.0),
            .fear: Int(1.0 / 11.0 * 100.0)
        ])
        .frame(width: 500, height: 500 / 4 * 3)
    }
}
