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
            ProgressView(processor.explainableState)
                .progressViewStyle(CircularProgressViewStyle())
            
        case .finished:
            finished
        }
    }
    
    var title: some View {
        Text("📊 Your insights")
            .font(.largeTitle)
            .bold()
    }
    
    // maybe change to use 3 x 2 instead of 2 x 3 if in landscape??
    var finished: some View {
        GeometryReader { geo in
            // want it to be 4:3 regardless of orientation
            let horizontal = geo.size.width > geo.size.height
            let multiplier = horizontal ? (0.5 * 0.7) : (0.33 * 0.7)
            let itemHeight = geo.size.height * multiplier
            let itemWidth = itemHeight * 4 / 3
            
            if horizontal {
                VStack {
                    title
                        .padding()
                    HStack {
                        Spacer()
                        emotionPerSetence
                            .frame(width: itemWidth, height: itemHeight)
                        Spacer()
                        emotionPercentage
                            .frame(width: itemWidth, height: itemHeight)
                        Spacer()
                        sentimentPerSentence
                            .frame(width: itemWidth, height: itemHeight)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        emotionPercentage
                            .frame(width: itemWidth, height: itemHeight)
                        Spacer()
                        overview
                            .frame(width: itemWidth * 2, height: itemHeight)
                        Spacer()
                    }
                    Spacer()
                }
            } else {
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
    }
    
    var emotionPerSetence: some View {
        EmotionPerSentence(processor.emotionPerSentence)
    }
    
    var emotionPercentage: some View {
        EmotionPrevalence(weights: processor.emotionWeight)
    }
    
    // 3. TODO: color top half a light green and bottom half a light red
    var sentimentPerSentence: some View {
        let total = processor.sentimentPerSentence.sum()
        let sentenceCount = processor.sentimentPerSentence.count
        let avg = total / sentenceCount
        
        return SentimentPerSentence(processor.sentimentPerSentence,
                             avg: avg)
    }
    
    // 4. Could plot all emotions and thier confidence per sentence??
    // 2 sided bar chart with emotions mapping to their average sentiment
    var emotionSentimentRelationship: some View {
        EmptyView()
    }
    
    // 5. (whole text in one analysis)
    var overview: some View {
        TodaysOverview(mostFrequentEmtion: processor.mostFrequentEmotion,
                       wholeTextEmotion: processor.wholeTextEmotion,
                       wholeTextSentiment: processor.wholeTextSentiment)
    }
}


// MARK: PREVIEW STUFF, MOCK DATA ETC -------------------------------------
struct Previews_Statistics_Previews: PreviewProvider {
    static var processor = TextProcessor()
    
    static var previews: some View {
        Statistics()
            .environmentObject(adapt())
    }
    
    static func adapt() -> TextProcessor {
        processor.analysisState = .finished
        processor.explainableState = "Calculating emotions..."
        
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
        processor.wholeTextEmotion = .joy
        
        processor.wholeTextSentiment = 60
        processor.mostFrequentEmotion = .joy
        
        return processor
    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}
