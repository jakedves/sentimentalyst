import SwiftUI
import Vision

struct MainScreen: View {
    @EnvironmentObject private var processor: TextProcessor
    @State var needsOnboarding: Bool
    @State var isCameraOpen = false
    @State var image: UIImage?
    
    public init(needsOnboarding: Bool) {
        self.needsOnboarding = needsOnboarding
    }
    
    // some Navigation would be nice
    var body: some View {
        NavigationView {
            VStack {
                DiaryForm()
                HStack {
                    Spacer()
                    Button("Use camera") {
                        self.isCameraOpen = true
                    }
                    Spacer()
                    loadExample
                    Spacer()
                }
                .frame(width: 400)
                
                NavigationLink(destination: Statistics()
                    .onAppear {
                        DispatchQueue(label: "NLP", qos: .userInitiated).async {
                            processor.analyseText()
                        }
                    }) {
                        insights
                    }
            }
        }
        .navigationViewStyle(.stack)
        .fullScreenCover(isPresented: $needsOnboarding) {
            OnBoarding(needsOnboarding: $needsOnboarding)
        }
        .sheet(isPresented: $isCameraOpen, onDismiss: processImage) {
            ImagePicker(image: self.$image, isShown: self.$isCameraOpen, sourceType: .camera)
        }
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
    
    private var loadExample: some View {
        Button("Use example") {
            processor.text =
"""
I had an amazing day today.

I watched some WWDC talks, learnt about Swift and practised writing some code. Swift Charts is so good, and the charts are so customizable! I had to fix so many bugs in my code however, and this made me so angry. I hate having to find typos and fixing data types.

Using the natural language framework Apple provides really demonstrates how trivial it is now to bring great power into modern apps. I was able to not only train a machine learning model with a few lines of code, but I could use it by simply dragging it in.
 How cool is that? I was a bit sad because it means some of the great complexity of NLP is hidden from the user, and I think that’s disappointing. I have to remember it’s a good thing overall, and makes everyone’s apps that much better.

After that I had my favourite dinner ever - sausage and mash. It was perfect. Delicious. Made to perfection. Now I plan to do some reading and catch up on sleep. Goodnight!
"""
        }
    }
    
    private func processImage() {
        guard let image = image else { return }
        guard let ciImage = CIImage(image: image) else { return }
            
        let handler = VNImageRequestHandler(ciImage: ciImage)
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            var detectedText = ""
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                detectedText += topCandidate.string + " "
            }
            
            self.processor.text = detectedText
        }
            
        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Previews_MainScreen_Previews: PreviewProvider {
    private static let yes = true
    private static let no = false
    
    static var previews: some View {
        MainScreen(needsOnboarding: no)
            .environmentObject(TextProcessor())
    }
}
