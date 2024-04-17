//
//  LoginView.swift
//  WanderLog
//
//  Created by Tanushree Arora on 2/26/24.
//

import SwiftUI
import FirebaseFirestore


struct LoginView: View {
    let db = Firestore.firestore()
    @State var users = [User]()
   
    @State private var username = ""
    @State private var password = ""
    @State private var loginSuccess = false
    @State private var incorrectPassword = false
    @State private var showSignUp = false

    
    var body: some View {
        NavigationStack {
            VStack {
                FullLogoView()
                VStack{
                    VStack {
                        TextField("Username", text: $username)
                            .padding(10)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth:1))
                            
                        SecureField("Password", text: $password)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth:1))
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
                    
                    NavigationLink(destination: NavBarUI(tabViewSelection: 0), isActive: $loginSuccess){}
                    Button( action:{
                        getUser()
                        
                    } ,label:{
                        Text("Login")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    })
                    .buttonStyle(.borderedProminent)
                    .padding()
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
        }
        .navigationBarBackButtonHidden(true)
    }
    func getLocations(){
//        self.locations = []
        if let currentUser = UserManager.shared.currentUser{
            db.collection("locations")
                .whereField("userID", isEqualTo: currentUser.id)
                .whereField("visited", isEqualTo: false)
                .getDocuments(){(querySnapshot,err) in
            if let err = err{ //error not nil
                print("Error getting documents: \(err)")
            }
            else{ //get locations from db
                for document in querySnapshot!.documents{
                    if let location = Locations(id:document.documentID, data: document.data()){
                        NotificationManager.instance.scheduleNotificationLocation(latitude: location.latitude, longitude: location.latitude)
                        }
                    }
                }
            }
        }
    }
    func getUser(){
        self.users = []
        db.collection("users").whereField("username", isEqualTo: username)
        .getDocuments(){
            (querySnapshot,err) in
            if let err = err{ //error not nil
                print("Error getting documents: \(err)")
            }
            else{ //get users from db
                for document in querySnapshot!.documents{
                    if let user = User(id:document.documentID, data: document.data()){
                        if user.password == password.hash{
                            print("Logged in")
                            loginSuccess = true
                            //update currentUser
                            UserManager.shared.updateUser(id: user.id, username: user.username, email: user.email,  bio: user.bio, fullname: user.fullname)
                            NotificationManager.instance.scheduleNotification()
                            getLocations()
                        }
                        else{
                            print(password.hash)
                            print("Fail")
                        }
                    }
                }
            }
        }
    }
}

#Preview  {
    LoginView()
}
