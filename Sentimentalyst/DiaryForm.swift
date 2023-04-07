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
                
                HelpImage() {
                    VStack {
                        Text("Write a diary entry, or take a picture of one.")
                            .padding([.bottom], 20)
                        Text("Top tips: write in first person, and the more you write the more accurate your results will be!")
                    }
                    .font(.body)
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
