//
//  OnboardingView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 13/12/22.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            VStack {
                Image("swift-firebase")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Hello !")
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
                Text("Best place to save your stories and share experiences whever you want")
                    .fontWeight(.thin)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Spacer()
                Button("Sign In", action: self.signIn)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        maxHeight: 35.0
                    )
                    .foregroundColor(.white)
                    .background(Color("ButtonBackgroundColor"))
                    .cornerRadius(5.0)
                    .padding(.bottom, 10.0)
                Button("Sign Up", action: self.signUp)
                    .frame(
                        minWidth: 0.0,
                        maxWidth: .infinity,
                        maxHeight: 35.0
                    )
                    .foregroundColor(.white)
                    .background(Color("ButtonBackgroundColor"))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 20.0)
            Spacer(minLength: 50.0)
            HStack(
                alignment: .center,
                spacing: 0.0
            ) {
                Text("made by:")
                    .foregroundColor(.white)
                    .padding(.leading, 10.0)
                Spacer()
                Image("zoominitcode-logo")
                    .resizable()
                .frame(
                    minWidth: 0.0,
                    maxWidth: 100.0,
                    minHeight: 0.0,
                    maxHeight: 50.0
                )
                Spacer(minLength: 100.0)
            }
            .frame(
                minWidth: 0.0,
                maxWidth: .infinity,
                minHeight: 0.0,
                maxHeight: 52.0
            )
            .background(Color.gray)
            .padding(.all, 20.0)
        }
    }
    
    func signIn() -> Void {
        print("signIn")
    }
    
    func signUp() -> Void {
        print("signUp")
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
