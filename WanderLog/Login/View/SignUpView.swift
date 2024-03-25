//
//  SignUpview1.swift
//  WanderLog
//
//  Created by Tanushree Arora on 3/21/24.
//

import SwiftUI
import FirebaseFirestore

struct SignUpView: View {
    let db = Firestore.firestore()
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var showLogin = false
    @State private var signUpSuccess = false
    var body: some View {
        NavigationView{
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
                
                NavigationLink(destination: LoginView(), isActive: $signUpSuccess){}
                Button( action:{
                    createUser()
                } ,label:{
                    Text("Sign Up")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                })
                .buttonStyle(.borderedProminent)
                .padding()
                
                    HStack(spacing:3){
                        Text("Already have an account?")
                        NavigationLink {
                            // destination view to navigation to
                            LoginView()
                        } label: {
                            Text("Sign In")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .font(.system(size:14))
                }
        }
        .navigationBarBackButtonHidden(true)
    }
    func createUser(){
        let data = ["username":username,
                    "email":email,
                    "fullname":fullname,
                    "password":password,
                    "bio":""] as [String:Any]
        var ref: DocumentReference? = nil
        ref = db.collection("users")
            .addDocument(data: data){ err in
                if let err = err{
                    print("Error in adding doc \(err)")
                }
                else{
                    print("Document added with ID : \(ref!.documentID)")
                    signUpSuccess = true
                }
            }
        
    }
    func resetTextFields(){
        email=""
        fullname=""
        username=""
        password=""
    }
    
}
    
#Preview {
    SignUpView()
}
