import Foundation

class TextProcessor: ObservableObject {
    @Published public var analysisState: AnalysisState = .none
    @Published public var text: String = ""
    private var previousText = ""
    
    private var processedText = ""
    private var lines: [String] = []
    
    enum AnalysisState {
        case none, loading, finished
    }
    
    public func analyseText() {
        guard previousText != text else {
            return
        }
        
        previousText = text
        self.analysisState = .loading
        print("Analyzing text...")
        
        print("Preprocessing...")
        preprocessText()
        
        // ...
        
        self.analysisState = .finished
        print("Text has been analyzed")
    }
    
    private func preprocessText() {
        processedText = text
        processedText = processedText
            .lowercased()
            .filteringEmojis()
            .removingApostropihes()
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
        return self.filter { $0 != "'" }
    }
}
