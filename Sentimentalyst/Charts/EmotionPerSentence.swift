//
//  EmotionPerSentence.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI

struct EmotionPerSentence: View {
    private let data: [Emotion]
    
    init(_ data: [Emotion]) {
        self.data = data
    }
    
    var body: some View {
        VStack {
            Text(Constants.title)
                .bold()
                .font(.title2)
            CategoryOverTime(categories: data,
                             xLabel: Constants.xLabel,
                             yLabel: Constants.yLabel,
                             colorScheme: emotionToColor)
        }
    }
    
    struct Constants {
        static let title = "Emotions"
        static let xLabel = "Sentence Number"
        static let yLabel = "Emotion"
    }
}

struct EmotionPerSentence_Previews: PreviewProvider {
    static var previews: some View {
        EmotionPerSentence([])
    }
}
