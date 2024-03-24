//
//  SignUpview1.swift
//  WanderLog
//
//  Created by Tanushree Arora on 3/21/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var showLogin = false
    var body: some View {
        NavigationStack {
        VStack{
            FullLogoView()
            
            TextField("Email ID", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .autocapitalization(.none)
            
            TextField("Full Name", text: $fullname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .disableAutocorrection(true)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
            
            Button {
                print("Login view was passed.")
            } label: {
                Text("Continue")
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 360, height: 44)
            .background(Color(.systemGray))
            .cornerRadius(10)
            
                HStack(spacing:3){
                    Text("Already have an account?")
                    Button{
                        showLogin = true
                    }label:{
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .font(.system(size:14))
            }
            
        }
        .navigationDestination(isPresented: $showLogin) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
    }
    
}
    
#Preview {
    SignUpView()
}
