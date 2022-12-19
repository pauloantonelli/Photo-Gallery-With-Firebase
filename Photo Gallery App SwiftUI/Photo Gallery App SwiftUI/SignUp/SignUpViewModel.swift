//
//  SignUpViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 19/12/22.
//

import Foundation

protocol ISignUpViewModel { }

struct SignUpViewModel: ISignUpViewModel {
    var username: String = ""
    var password: String = ""
    var isLoading: Bool = false
    
    
}
