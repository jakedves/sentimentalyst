//
//  EmotionPerSentence.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI
import Charts

struct EmotionPerSentence: View {
    private let data: [String]
    let xLabel = "Sentence Number"
    let yLabel = "Emotion"
    
    init(_ data: [Emotion]) {
        self.data = data.map(\.rawValue.capitalized)
    }
    
    var body: some View {
        VStack {
            Text(Constants.title)
                .bold()
                .font(.title2)
            Chart(data.indices, id: \.self) { index in
                let emotion = data[index]
                RectangleMark(xStart: .value(xLabel, index + 1),
                        xEnd: .value(xLabel, index + 2),
                        y: .value(yLabel, emotion.description)
                )
                .foregroundStyle(by: .value(xLabel, emotion.description))
            }
            .chartXAxisLabel(xLabel, position: .bottom, alignment: .center)
            .chartForegroundStyleScale([
                "Anger" : .red,
                "Sadness" : .blue,
                "Joy" : .green,
                "Fear" : .gray,
                "Love" : .purple.opacity(0.7),
                "Unknown" : .orange
            ])
        }
    }
    
    struct Constants {
        static let title = "Emotions"
    }
}

struct EmotionPerSentence_Previews: PreviewProvider {
    static var previews: some View {
        EmotionPerSentence([
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
        ])
        .frame(width: 500, height: 500 / 4 * 3)
    }
}
