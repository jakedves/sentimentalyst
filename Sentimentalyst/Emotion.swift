import Foundation

enum Emotion: String, CaseIterable, Identifiable {
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
