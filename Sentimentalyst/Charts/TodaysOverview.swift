//
//  TodaysOverview.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 02/04/2023.
//

import SwiftUI

struct TodaysOverview: View {
    private let overallEmotion: Emotion
    private let mostFrequentEmtion: Emotion
    private let sentiment: Int
    
    init(mostFrequentEmtion: Emotion,
         wholeTextEmotion: Emotion,
         wholeTextSentiment: Int) {
        self.overallEmotion = wholeTextEmotion
        self.sentiment = wholeTextSentiment
        self.mostFrequentEmtion = mostFrequentEmtion
    }
    
    var body: some View {
        VStack {
            Text(Constants.todaysOverview)
                .bold()
                .font(.title2)
            HStack {
                VStack {
                    Text(emotionToEmoji[overallEmotion] ?? "")
                        .font(.system(size: 150.0))
                    Text(overallEmotion.rawValue.capitalized)
                        .font(.caption)
                    Text(emotionTip[overallEmotion] ?? "")
                        .font(.subheadline)
                }
                .padding([.horizontal], 20)
                
                VStack {
                    Spacer()
                    HStack {
                        Text(Constants.overallEmotion)
                            
                        HelpImage() {
                            Text(Constants.explainer)
                                .multilineTextAlignment(.center)
                                .frame(width: 400)
                        }
                    }
                    .font(.title3)
                    
                    Text("\(overallEmotion.rawValue.uppercased())")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(Constants.mostFrequentEmotionTitle)
                        .font(.title3)
                    Text("\(mostFrequentEmtion.rawValue.uppercased())")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(Constants.overallSentimentScore)
                        .font(.title3)
                    Text("\(sentiment)")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding([.horizontal], 20)
            }
        }
    }
    
    struct Constants {
        static let todaysOverview = "Today's Overview"
        static let overallEmotion = "Overall emotion"
        static let mostFrequentEmotionTitle = "Most frequent emotion"
        static let overallSentimentScore = "Overall sentiment score"
        static let explainer = "Overall emotion is calculated by reading the whole text in one go. It may be different to your most frequent emotion."
    }
}

struct TodaysOverview_Previews: PreviewProvider {
    static var previews: some View {
        TodaysOverview(mostFrequentEmtion: .sadness, wholeTextEmotion: .sadness, wholeTextSentiment: 80)
    }
}
