import SwiftUI

struct DiaryForm: View {
    @State private var formWidth: CGFloat = 400
    @EnvironmentObject private var processor: TextProcessor
    
    public init() {}
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("✏️ Talk about your day...")
                    .bold()
                
                Spacer()
                
                Image(systemName: "questionmark.circle")
                    .onTapGesture {
                        // SHOW HELP
                        
                        // TALK ABOUT NLP/AI
                        
                        // TALK IN FIRST PERSON
                        
                        // THE MORE TEXT THE BETTER
                    }
            }
            .font(.title)
            CustomTextEditor(text: $processor.text, width: $formWidth)
        }
        .frame(width: formWidth)
    }
}

struct Previews_DiaryForm_Previews: PreviewProvider {
    static var previews: some View {
        DiaryForm()
            .environmentObject(TextProcessor())
    }
}
