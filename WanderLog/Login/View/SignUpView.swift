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
    @State private var confirmPassword = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var showLogin = false
    @State private var signUpSuccess = false
    @State private var emptyFields = false
    @State private var passwordMismatch = false
    var body: some View {
        NavigationView{
            VStack{
                FullLogoView()
                
                TextField("Email ID *", text: $email)
                    .padding(10)
                    .autocapitalization(.none)
                
                TextField("Full Name *", text: $fullname)
                    .padding(10)
                    .disableAutocorrection(true)
                
                TextField("Username *", text: $username)
                    .padding(10)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                SecureField("Password *", text: $password)
                    .padding(10)
                
                SecureField("Confirm Password *", text: $confirmPassword)
                    .padding(10)
                    
                if emptyFields{
                    Text("Please enter all the required fields!")
                        .foregroundStyle(.red)
                }
                if passwordMismatch{
                    Text("Passwords don't match! Please Try again!")
                        .foregroundStyle(.red)
                }
                
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
        .padding()
    }
    func checkPassword(){
        if confirmPassword != password{
            passwordMismatch = true
        }
        else{
            passwordMismatch = false
        }
    }
    func createUser(){
        //if any text field is left empty, should show error
        if email == "" || username == "" || fullname == "" || password == "" || confirmPassword == ""{
            emptyFields = true
            
        }
        //if passwords dont match, should show error
        else if confirmPassword != password{
            passwordMismatch = true
        }
        //otherwise sign up complete
        else{
            emptyFields = false
            passwordMismatch = false
            let data = ["username":username,
                        "email":email,
                        "fullname":fullname,
                        "password":password.hash,
                        "bio":""] as [String:Any]
            var ref: DocumentReference? = nil
            //Add entry to db
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
        
    }
}
    
#Preview {
    SignUpView()
}
