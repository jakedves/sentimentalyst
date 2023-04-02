import SwiftUI
import Charts

struct Statistics: View {
    @EnvironmentObject var processor: TextProcessor
    @State var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ViewBuilder
    var body: some View {
        switch processor.analysisState {
        case .none:
            Text("You didn't write anything!")
            
        case .loading:
            loading
            
        case .finished:
            finished
        }
    }
    
    var loading: some View {
        ProgressView("Analyzing your entry 👀")
            .progressViewStyle(CircularProgressViewStyle())
    }
    
    // maybe change to use 3 x 2 instead of 2 x 3 if in landscape??
    var finished: some View {
        GeometryReader { geo in
            // want it to be 4:3 regardless of orientation
            let itemHeight = geo.size.height * 0.33 * 0.7 // 3 rows and less
            let itemWidth = itemHeight * 4 / 3
            VStack {
                Spacer()
                title
                Spacer()
                HStack {
                    Spacer()
                    emotionPerSetence
                        .frame(width: itemWidth, height: itemHeight)
                    Spacer()
                    emotionPercentage
                        .frame(width: itemWidth, height: itemHeight)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    sentimentPerSentence
                        .frame(width: itemWidth, height: itemHeight)
                    Spacer()
                    emotionPercentage
                        .frame(width: itemWidth, height: itemHeight)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    overview
                        .frame(width: itemWidth * 2, height: itemHeight)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    var title: some View {
        Text("📊 Your insights")
            .font(.largeTitle)
            .bold()
    }
    
    // 1. Could plot all emotions and thier confidence per sentence??
    var emotionPerSetence: some View {
        VStack {
            Text("Emotion Per Sentence")
                .bold()
                .font(.title2)
            CategoryOverTime(categories: processor.emotionPerSentence,
                             xLabel: "Sentence Number",
                             yLabel: "Emotion",
                             colorScheme: emotionToColor)
        }
    }
    
    // 2.
    var emotionPercentage: some View {
        VStack {
            Text("Emotion Percentages")
                .bold()
                .font(.title2)
            Chart {
                ForEach(Emotion.allCases) { emotion in
                    BarMark(x: .value("Emotion", emotion.rawValue.capitalized),
                            y: .value("Percentage", processor.emotionWeight[emotion] ?? 0)
                    )
                    .foregroundStyle(emotionToColor[emotion] ?? .black)
                }
            }
            .chartYAxisLabel("Percentage of Sentences (%)")
        }
    }
    
    // 3. TODO: color top half a light green and bottom half a light red
    var sentimentPerSentence: some View {
        VStack {
            Text("Sentiment Per Sentence")
                .bold()
                .font(.title2)
            Chart {
                ForEach(processor.sentimentPerSentence.indices, id: \.self) { index in
                    let sentiment = processor.sentimentPerSentence[index]
                    LineMark(x: .value("Sentence", index + 1),
                            y: .value("Percentage", sentiment)
                    )
                }
            }
            .chartYAxisLabel("Positive", position: .top, alignment: .trailing)
            .chartYAxisLabel("Negative", position: .bottom, alignment: .trailing)
            .chartXAxisLabel("Sentence Number", position: .bottom, alignment: .center)
        }
    }
    
    // 4. Could plot all emotions and thier confidence per sentence??
    // some kind of gas plot?
    // interactive picker component
    var idek: some View {
        EmptyView()
    }
    
    
    // 5. (whole text in one analysis)
    var overview: some View {
        VStack {
            let overallEmotion = processor.wholeTextEmotion
            let sentiment = processor.wholeTextSentiment
            Text("Today's Overview")
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
                    Text("Overall emotion:")
                        .font(.title3)
                    Text("\(overallEmotion.rawValue.uppercased())")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("Most frequent emotion:")
                        .font(.title3)
                    Text("\(processor.mostFrequentEmotion.rawValue.uppercased())")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("Overall sentiment score:")
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
}

struct Previews_Statistics_Previews: PreviewProvider {
    static var processor = TextProcessor()
    
    static var previews: some View {
        Statistics()
            .environmentObject(adapt())
    }
    
    static func adapt() -> TextProcessor {
        processor.analysisState = .finished
        
        processor.emotionWeight = [
            .unknown : Int(1.0 / 11.0 * 100.0),
            .joy: Int(4.0 / 11.0 * 100.0),
            .anger: Int(2.0 / 11.0 * 100.0),
            .sadness: Int(1.0 / 11.0 * 100.0),
            .love: Int(2.0 / 11.0 * 100.0),
            .fear: Int(1.0 / 11.0 * 100.0)
        ]
        
        processor.emotionPerSentence = [
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
        
        let sentimentScores: [Int] = [
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
        
        processor.sentimentPerSentence = sentimentScores
        processor.wholeTextEmotion = .love
        
        processor.wholeTextSentiment = 60
        processor.mostFrequentEmotion = .joy
        
        return processor
    }
}
