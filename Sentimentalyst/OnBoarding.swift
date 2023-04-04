//
//  OnBoarding.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 03/04/2023.
//

import SwiftUI

struct OnBoarding: View {
    @Binding var needsOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            TabView {
                welcome
                diary
                interactions
                technologies
                getStarted
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .ignoresSafeArea()
        .foregroundColor(.white)
    }
    
    // welcome user
    // this app is...
    var welcome: some View {
        ZStack {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Text("Welcome to")
                Text("Sentimentalyst")
                    .font(.system(size: 40))
                    .bold()
                Spacer()
                
                // icons
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "1.square")
                            .font(.system(size: 40))
                            .bold(false)
                        Text("Diary")
                    }
                    .padding()
                    
                    HStack {
                        Image(systemName: "2.square")
                            .font(.system(size: 40))
                            .bold(false)
                        Text("Natural Language Processing")
                    }
                    .padding()
                    
                    HStack(alignment: .center) {
                        Image(systemName: "3.square")
                            .font(.system(size: 40))
                            .bold(false)
                        Text("Insights")
                    }
                    .padding()
                }
                .font(.system(size: 25))
                .bold()
                .padding()
                Spacer()
                
                Text("Swipe left to go further")
                Spacer()
            }
        }
    }
    
    // we can type, write text using the stylus,
    // or upload text using the camera button.
    
    // there is also an option to load some example text
    // just for trying the app out
    var diary: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Text("📔 Diary")
                .font(.system(size: 40))
                .bold()
                .padding()
            Text("This app allows for a few different ways to fill in your diary entry")
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                .frame(width: 400)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "keyboard")
                        .font(.system(size: 40))
                        .bold(false)
                    Text("Type it in")
                }
                .padding()
                
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 40))
                        .bold(false)
                    Text("Take a photo")
                }
                .padding()
                
                HStack(alignment: .center) {
                    Image(systemName: "pencil")
                        .font(.system(size: 40))
                        .bold(false)
                        .offset(x: 11)
                    Text("Use Apple Pencil")
                        .offset(x: 15)
                }
                .padding()
                
            }
            .font(.system(size: 25))
            .bold()
            .padding()
            Spacer()
            Spacer()
        }
    }
    
    // some of the graphs are interactive. You can press,
    // drag and hold onto them for more detailed information
    
    // press any ? icons you see - TODO: add one to this view
    // try it now!
    var interactions: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Text("🌟 Interactivity")
                .font(.system(size: 40))
                .bold()
                .padding()
            Text("Some graphs are interactable. If you see a ? icon, press it to see how to interact with that graph")
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                .frame(width: 400)
            
            Text("Try tapping the icon below")
                .font(.system(size: 20))
                .padding()
            Spacer()
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 80.0, height: 80.0)
                    .cornerRadius(15.0)
                HelpImage {
                    Text("This is an example")
                        .foregroundColor(.black)
                }
                .scaleEffect(2.0)
                .foregroundColor(.blue)
            }
            Spacer()
            Spacer()
        }
    }
    
    // this app uses a combination of Apple's finest technologies
    // For analysing the text, I used Apple's Natural Language
    // framework, and trained my own custom machine learning model
    // to detect emotion. Analysing sentiment and detecting sentences
    // was built in
    
    // to display the data in a beautiful, interactive way,
    // I used SwiftUI, with Swift Charts
    // idea: chart that changes bar heights constantly
    var technologies: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Text("🛠 Technologies")
                .font(.system(size: 40))
                .bold()
                .padding()
            Text("This app uses the latest and greatest")
                .font(.system(size: 25))
                .bold()
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("📈    ")
                    Text("CreateML")
                        .bold()
                    Text("trained machine learning model (for emotion)")
                }
                
                HStack {
                    Text("👄    ")
                    Text("Apple's")
                    Text("Natural Language")
                        .bold()
                    Text("framework (for sentiment)")
                }
                .padding([.vertical])
                
                HStack {
                    Text("📈    ")
                    Text("Swift Charts")
                        .bold()
                    Text("for displaying data beautifully")
                }
            }
            .font(.system(size: 30))
            .padding()
            //.bold()
            Spacer()
            Spacer()
        }
    }
    
    // get started by pressing "Load Example!" -> Analyse
    // you can always go back later!
    var getStarted: some View {
        // button that sets the app storage property to false
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Text("Ready to get started?!")
                .font(.system(size: 40))
                .bold()
                .padding()
            
            Text("Press 'Use Example' to load some default text")
                .font(.system(size: 25))
                .bold()
            Spacer()
            ZStack {
                Color.white
                    .frame(width: 120, height: 60)
                    .cornerRadius(15.0)
                Button("Let's go!") {
                    needsOnboarding = false
                }
                .foregroundColor(.black)
                .padding(100)
            }
            
            Spacer()
        }
        
    }
}

struct OnBoarding_Previews: PreviewProvider {
    @State private static var needs = true
    
    static var previews: some View {
        OnBoarding(needsOnboarding: $needs)
    }
}
