//
//  LoginView.swift
//  SwiftUI_Lesson1
//
//  Created by Denis on 24.05.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
            
            VStack {
                
                Text("Sign Up")
                    .padding(.top, 30)
                
                Spacer()
                
                TextField(
                  "Login",
                  text: $viewModel.login
                ).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                
                SecureField(
                  "Password",
                  text: $viewModel.password
                ).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                
                NavigationLink(destination: SuccessfulLoginView(name: viewModel.login)) {
                    Text("Login")
                }
                
                Spacer()
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
