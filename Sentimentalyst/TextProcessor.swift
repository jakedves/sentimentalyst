import Foundation
import CoreML
import NaturalLanguage

class TextProcessor: ObservableObject {
    @Published public var analysisState: AnalysisState = .none
    
    @Published public var text: String = ""
    private var previousText: String = ""
    private var processedText: String = ""
    
    // update this so that user knows what's happening
    @Published public var explainableState = ""
    
    // 1. bar graph - emotion per sentence
    @Published public var emotionPerSentence: [Emotion] = []
    
    // 2. pie chart - percentage of text with each emotion
    public var emotionWeight: [Emotion : Int] = [
        .unknown : 0,
        .love : 0,
        .fear : 0,
        .sadness : 0,
        .anger : 0,
        .joy : 0
    ]
    
    // 3. two-sided bar chart - sentiment per sentence
    @Published public var sentimentPerSentence: [Int] = []
    
    // 4.
    
    // 5. overall emotion
    @Published public var wholeTextEmotion: Emotion = .unknown
    
    // 6a. overall day rating - sentiment (as a percentage)
    @Published public var wholeTextSentiment: Int = 0
    
    // 6b. overall day rating - most frequent emotion (per sentence breakdown)
    @Published public var mostFrequentEmotion: Emotion = .unknown
    
    enum AnalysisState {
        case none, loading, finished
    }
    
    init() {}
    
    public func analyseText() {
        guard previousText != text else {
            print("Analysis skipped as text hasn't changed since last analysis")
            return
        }
        
        beginAnalysis() // sets previous text as it has changed, and sets state to loading
        preprocessText()
        computeEmotions(text: processedText)
        computeSenitment(text: processedText)
        
        DispatchQueue.main.async {
            self.analysisState = .finished
        }
        print("Text has been analyzed")
    }
    
    private func beginAnalysis() {
        DispatchQueue.main.async {
            self.explainableState = "Begining analysis..."
            self.analysisState = .loading
        }
        previousText = text
    }
    
    private func preprocessText() {
        DispatchQueue.main.async {
            self.explainableState = "Preprocessing..."
        }
        processedText = text
            .lowercased()
            .filteringEmojis()
            .removingApostropihes()
            .separatingSentences()
    }
    
    private func computeEmotions(text: String) {
        DispatchQueue.main.async {
            self.explainableState = "Calculating emotions..."
        }
        let emotionAnalyser = EmotionAnalyser(text)
        
        // set emotion weights and remember frequent emotion
        let numberOfSentences = Double(emotionAnalyser?.labelPerSentence.count ?? 1)
        
        var maxSeen = (0.0, Emotion.unknown)
        for emotion in Emotion.allCases {
            let list = emotionAnalyser?.labelPerSentence.filter({ $0 == emotion }) ?? []
            let occurancesOfEmotion = Double(list.count)
            let percentage = occurancesOfEmotion / numberOfSentences * 100
            self.emotionWeight[emotion] = Int(percentage)
            if percentage > maxSeen.0 {
                maxSeen = (percentage, emotion)
            }
        }
        
        DispatchQueue.main.async {
            // set emotionPerSentence
            self.emotionPerSentence = emotionAnalyser?.labelPerSentence ?? []
            self.mostFrequentEmotion = maxSeen.1
            
            // set wholeTextEmotion
            self.wholeTextEmotion = emotionAnalyser?.labelOverall ?? .unknown
        }
        
    }
    
    private func computeSenitment(text: String) {
        DispatchQueue.main.async {
            self.explainableState = "Calculating sentiment..."
        }
        let sentimentAnalyser = SentimentAnalyser(text)
        
        DispatchQueue.main.async {
            self.sentimentPerSentence = sentimentAnalyser.labelPerSentence.map({ Int($0 * 100) })
            
            // .labelOverall is a one-decimal-place double
            self.wholeTextSentiment = Int(sentimentAnalyser.labelOverall * 100)
        }
    }
}

extension String {
    func filteringEmojis() -> String {
        return self.filter { char in
            !(char.unicodeScalars.contains { scalar in
                scalar.properties.isEmoji
            })
        }
    }
    
    func removingApostropihes() -> String {
        return self
            .replacing("’", with: " ")
            .replacing("'", with: " ")
    }
    
    func separatingSentences() -> String {
        return self
            .replacing(". ", with: ".\n")
            .replacing("? ", with: "?\n")
            .replacing("! ", with: "!\n")
    }
}
