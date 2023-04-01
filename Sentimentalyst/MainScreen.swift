import SwiftUI

struct MainScreen: View {
    @StateObject private var processor = TextProcessor()

    public init() {}
    
    // some Navigation would be nice
    var body: some View {
        NavigationView {
            VStack {
                DiaryForm(processor)
                NavigationLink(destination: Statistics(processor).onAppear {
                    processor.analyseText()
                }) {
                    insights
                    
                    // TODO: Read text from VISION
                }
                
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private var insights: some View {
        Text("Insights 🔍")
            .foregroundColor(.white)
            .padding()
            .frame(width: 120)
            .background(Color.blue)
            .cornerRadius(15.0, antialiased: true)
            .padding()
    }
}

struct Previews_MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
