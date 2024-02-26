//
//  LoginView.swift
//  WanderLog
//
//  Created by Tanushree Arora on 2/26/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
      
                
                //logo image
                Image("full-white")
                    .resizable()
                    .scaledToFit()
//                    .frame(width: 400,height: 600)
                    
                VStack{
                    VStack {
                        TextField("Enter Your Email", text: $email)
                            .padding(10)
                            
                        SecureField("Password", text: $password)
                            .padding(10)

                    }.padding(20)
                        
                    
                    Button {
                        print("show forget password")
                    } label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing, 28)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Button {
                        print("login")
                    } label: {
                        Text("Log In")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 44)
                            .background(Color(.systemBlue))
                            .cornerRadius(10)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                        
                        Text("OR")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        
                        Rectangle()
                            .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    }
                    .foregroundColor(.gray)
                    
                    HStack {
                        Image("apple")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Continue with Apple")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 8)
                }
                .offset(y: -120)
                //text fields
                
                
                Spacer()
                
                Divider()
                
                
            }
        }
    }
}

#Preview  {
    LoginView()
}
