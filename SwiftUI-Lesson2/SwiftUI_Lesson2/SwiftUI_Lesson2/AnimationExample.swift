//
//  AnimationExample.swift
//  SwiftUI_Lesson2
//
//  Created by Denis on 26.05.2022.
//

import SwiftUI

struct AnimationExample: View {
    @State private var angle = 0.0
    @State private var borderThickness = 1.0
    @State private var circleAnimationAmount = 1.0
    @State private var heartChange = false
    
    var body: some View {
        NavigationView {
        VStack {
            Spacer()
            
            Text("Hey")
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(circleAnimationAmount)
                    .opacity(2 - circleAnimationAmount)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: circleAnimationAmount
                    )
            )
            .onAppear {
                circleAnimationAmount = 2
            }
            
            Spacer()
            
            Button("Press here") {
                angle += 45
                borderThickness += 1
            }
            .padding()
            .border(.red, width: borderThickness)
            .rotationEffect(.degrees(angle))
            .animation(.easeOut, value: angle)
            
            Spacer()
            
            Image(systemName: heartChange ? "heart.fill" : "heart")
                .font(.system(size: 100))
                .foregroundColor(heartChange ? .red : .black)
                .scaleEffect(heartChange ? 1.5 : 1.0)
                .onTapGesture {
                    withAnimation {
                        self.heartChange.toggle()
                    }
                }
            
            Spacer()
            
            NavigationLink(destination: UIViewRepresentableExample()) {
                Text("To animation example")
            }
        }
    }
    }
}

struct AnimationExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationExample()
    }
}


//struct Watermark: ViewModifier {
//    @Binding var isAnimating: Bool
//    @Binding var value: Double
//
//    func body(content: Content) -> some View {
//        if isAnimating {
//            content.animation(
//                .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: false),
//                value: value
//            )
//        } else {
//            content
//        }
//
//    }
//}
