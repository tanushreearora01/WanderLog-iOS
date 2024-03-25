//
//  LoginView.swift
//  WanderLog
//
//  Created by Tanushree Arora on 2/26/24.
//

import SwiftUI
import FirebaseFirestore
//import UsefulValues

struct LoginView: View {
    let db = Firestore.firestore()
    @State var users = [User]()
   
    @State private var username = ""
    @State private var password = ""
    @State private var loginSucces = false
    @State private var incorrectPassword = false
    @State private var showSignUp = false

    
    var body: some View {
        NavigationView {
            VStack {
                FullLogoView()
                VStack{
                    VStack {
                        TextField("Username", text: $username)
                            .padding(10)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            
                        SecureField("Password", text: $password)
                            .padding(10)

                    }.padding(20)
                    if incorrectPassword{
                        Text("Incorrect Password! Please Try again!")
                            .foregroundStyle(.red)
                    }
                        
                        
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
                    
                   
//                    NavigationStack {
                        Button {
                            print("login")
                            login()
                            print($loginSucces)
                        } label: {
                        Text("Log In")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 44)
                            .background(Color(.systemBlue))
                            .cornerRadius(10)
                        }
                        .sheet(isPresented: $loginSucces) {
                            NavBarUI(tabViewSelection: 4)
                        }
//                    }
//                    .navigationBarBackButtonHidden(true)
//                    .navigationDestination(isPresented: $loginSucces) {
//                                     NavBarUI(tabViewSelection: 4)
//                                     }
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
                        Image(systemName: "apple.logo")
                            .resizable()
                            .frame(width: 14, height: 14)

                        
                        Text("Continue with Apple")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 8)
                    Spacer()
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    HStack(spacing:3){
                        Text("Don't have an account yet?")
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .font(.system(size:14))
                }
            }
            .onAppear(){
                getUser()
            }
        }
        
    }
    func login(){
        let data = [username,password]
        if (data[0]=="" || data[1]==""){
            print("Login failed!")
            username = ""
            password = ""
        }
        else{
            for i in users{
                if(i.username == data[0]){
                    if(i.password == data[1]){
                        print("Login Success")
                        loginSucces = true
                        UserManager.shared.updateUser(id: i.id, username: i.username, email: i.email,  bio: i.bio, fullname: i.fullname)
                    }
                    else{
                        incorrectPassword = true
                        print("Incorrect Password")
                    }
                    break
                }
                else{
                    print("User not found!")
                    username = ""
                    password = ""
                }
            }
        }
    }
    func getUser(){
        self.users = []
        db.collection("users")
        .getDocuments(){
            (querySnapshot,err) in
            if let err = err{ //error not nil
                print("Error getting documents: \(err)")
            }
            else{ //get users from db
                for document in querySnapshot!.documents{
                    print("\(document.documentID)")
                    if let user = User(id:document.documentID, data: document.data()){
                        print("\(user)")
                        self.users.append(user)
//                        print(document.data())
                    }
                }
            }
        }
    }
}

#Preview  {
    LoginView()
}
