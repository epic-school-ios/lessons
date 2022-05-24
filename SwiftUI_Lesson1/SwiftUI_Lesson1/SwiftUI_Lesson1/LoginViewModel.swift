//
//  LoginViewModel.swift
//  SwiftUI_Lesson1
//
//  Created by Denis on 24.05.2022.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
}
