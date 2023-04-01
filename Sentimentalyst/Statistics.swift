import SwiftUI

struct Statistics: View {
    @ObservedObject var processor: TextProcessor
    
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
