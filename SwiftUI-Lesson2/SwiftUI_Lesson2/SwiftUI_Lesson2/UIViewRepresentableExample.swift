//
//  UIViewRepresentableExample.swift
//  SwiftUI_Lesson2
//
//  Created by Denis on 26.05.2022.
//

import SwiftUI

struct UIViewRepresentableExample: View {
    @State var isActivityIndicatorAnimating = false
    
    var body: some View {
            VStack {
                
                Spacer()
                
                ActivityIndicator(isAnimating: $isActivityIndicatorAnimating)
                
                Spacer()
                
                Button("Toggle Activity Indicator") {
                    isActivityIndicatorAnimating.toggle()
                }
                
                Spacer()
                
            }
    }
}

struct UIViewRepresentableExample_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableExample()
    }
}


struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        
        return v
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
