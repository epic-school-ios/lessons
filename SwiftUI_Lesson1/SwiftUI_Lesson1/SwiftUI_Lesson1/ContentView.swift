//
//  ContentView.swift
//  SwiftUI_Lesson1
//
//  Created by Denis on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var labelText: String = "Hello"
    @State var wordToAdd: String = ""
    
    @State var buttonTextColor: Color = .red
    @State var buttonBackgroundColor: Color = .white
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.purple
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text(labelText)
                        .fontWeight(.bold)
                        .foregroundColor(Color.green)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                    
                    HStack(alignment: .center, spacing: 10) {
                        Spacer()
                        
                        TextField(
                          "Type a word to add",
                          text: $wordToAdd
                        ).padding(.all, 10)
                        .background(Color.gray)
                        .multilineTextAlignment(TextAlignment.center)
                        .cornerRadius(15)
                        
                        Button("Add word!") {
                            labelText += " \(wordToAdd)"
                        }.padding(.all, 10)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(15)
                        
                        Spacer()
                    }.padding()
                    .background(Color.blue)
                    
                    Button("ChangeColor") {
                        buttonTextColor = .random
                        buttonBackgroundColor = .random
                    }.padding(.all, 10)
                    .foregroundColor(buttonTextColor)
                    .background(buttonBackgroundColor)
                    .cornerRadius(15)
                    
                    NavigationLink(destination: LoginView(viewModel: .init())) {
                        Text("Go to Sign Up")
                            .padding(.all, 10)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(15)
                    }
                }
            }
        }.onAppear(perform: {
            labelText = "hi"
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    static private var randomUIColor: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    static var random: Color {
        Color(randomUIColor)
    }
}
