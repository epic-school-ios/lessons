//
//  SuccessfulLoginView.swift
//  SwiftUI_Lesson1
//
//  Created by Denis on 24.05.2022.
//

import SwiftUI

struct SuccessfulLoginView: View {
    let name: String
    
    var body: some View {
        Text("Hello, \(name)!")
    }
}

struct SuccessfulLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessfulLoginView(name: "Bob")
    }
}
