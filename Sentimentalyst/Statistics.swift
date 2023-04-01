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
    
    var finished: some View {
        GeometryReader { geo in
            let itemWidth = geo.size.width * 0.5 * 0.75 // two column and less
            let itemHeight = geo.size.height * 0.33 * 0.7 // 3 rows and less
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
                    idek
                        .frame(width: itemWidth, height: itemHeight)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    overallEmotion
                        .frame(width: itemWidth, height: itemHeight)
                    Spacer()
                    overallDayRating
                        .frame(width: itemWidth, height: itemHeight)
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
    
    // 1.
    var emotionPerSetence: some View {
        EmptyView()
    }
    
    // 2.
    var emotionPercentage: some View {
        Chart {
            ForEach(Emotion.allCases) { emotion in
                BarMark(x: .value("Emotion", emotion.rawValue),
                        y: .value("Percentage", processor.emotionWeight[emotion] ?? 0)
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: Emotion.allCases.map(\.rawValue)) { str in
                AxisGridLine(stroke: StrokeStyle())
                AxisValueLabel(str.as(String.self)!.capitalized)
            }
        }
    }
    
    // 3.
    var sentimentPerSentence: some View {
        EmptyView()
    }
    
    // 4.
    var idek: some View {
        EmptyView()
    }
    
    
    // 5. (whole text in one analysis)
    var overallEmotion: some View {
        EmptyView()
    }
    
    // 6. overall day rating (sentiment whole + most freq emotion)
    var overallDayRating: some View {
        EmptyView()
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
        
        // 6 random numbers adding up to 100
        let sixNums = sixRandomNumbers()
        
        processor.emotionWeight = [
            .unknown : sixNums[0],
            .joy: sixNums[1],
            .anger: sixNums[2],
            .sadness: sixNums[3],
            .love: sixNums[4],
            .fear: sixNums[5]
        ]
        
        
        return processor
    }
    
    // generate six random numbers that add to 100 (percentage)
    static func sixRandomNumbers() -> [Int] {
        var numbers = [Int]()
        var sum = 0

        // Generate five random numbers
        for i in 1...5 {
            let randomNum = Int.random(in: 1...100-sum-(5-i))
            numbers.append(randomNum)
            sum += randomNum
        }

        // Calculate the sixth number to make the total sum to 100
        let lastNum = 100 - sum
        numbers.append(lastNum)
        
        return numbers
    }
}
