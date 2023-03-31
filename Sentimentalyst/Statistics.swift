import SwiftUI

struct Statistics: View {
    @ObservedObject var processor: TextProcessor
    
    // overall day rating
    
    // overall emotion
    
    // strongest emotion
    
    // percentage of text with each emotion
    
    // sentiment percentage per sentence
    
    // overall sentiment score
    
    init(_ processor: TextProcessor) {
        self.processor = processor
    }
    
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
        Text("Here are your statistics")
    }
}

struct Previews_Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics(TextProcessor())
    }
}
