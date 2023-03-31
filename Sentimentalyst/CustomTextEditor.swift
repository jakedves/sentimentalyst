import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    @Binding var width: CGFloat
    @State var preview = Constants.previewString
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15)
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding()
                .foregroundColor(text.isEmpty ? .gray : .primary)
                .onTapGesture {
                    preview = ""
                }
                .onChange(of: text, perform: { value in
                    if text.withoutWhitespace.isEmpty {
                        preview = Constants.previewString
                    } else {
                        preview = ""
                    }
                })
            
            VStack(alignment: .leading) {
                HStack {
                    Text(preview)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding([.top], 25.0)
                        .padding([.leading], 22.0)
                    Spacer()
                }
                Spacer()
            }
            .frame(width: width)
        }
        .frame(height: width * 0.75)
        
        .cornerRadius(15.0, antialiased: true)
    }
    
    struct Constants {
        static let previewString = "Today I had some really nice ice cream..."
    }
}

extension String {
    var withoutWhitespace: String {
        return self
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
}

struct Previews_CustomTextEditor_Previews: PreviewProvider {
    @State static var text = ""
    @State static var width: CGFloat = 400
    
    static var previews: some View {
        CustomTextEditor(text: $text, width: $width)
    }
}
