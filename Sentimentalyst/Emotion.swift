import Foundation
import Charts

enum Emotion: String, CaseIterable, Identifiable, Plottable {
    var description: String {
        self.rawValue.capitalized
    }
    
    var id: String {
        self.rawValue
    }
    
    case sadness = "sadness"
    case joy = "joy"
    case love = "love"
    case anger = "anger"
    case fear = "fear"
    case unknown = "unknown"
}
