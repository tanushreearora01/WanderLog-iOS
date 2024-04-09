//
//  ChangePasswordView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/7/24.
//

import SwiftUI
import FirebaseFirestore

struct ChangePasswordView: View {
    @State var password = ""
    @State var rightpass = 0
    @State var newpass = ""
    @State var confirmnewwpass = ""
    @State var passmatch = false
    @State var wrongpass = false
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Current Password")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    SecureField("Enter Password", text: $password)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                HStack{
                    Text("New Password")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    SecureField("New Password", text: $newpass)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                HStack{
                    Text("Confirm Password")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    SecureField("Confirm Password", text: $confirmnewwpass)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Spacer()
                    .frame(height: 20)
                if passmatch{
                    Text("Passwords don't match! Try Again!")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.red)
                }
                if wrongpass{
                    Text("Incorrect Password! Try Again!")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.red)
                }
                Spacer()
                    .frame(height: 50)
                
                Button{
                    submit()
                }label:{
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                Button{}label:{
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .onAppear(){
                getUserData()
            }
        }
        .navigationTitle("Change Password")
    }
    func getUserData(){
        let db = Firestore.firestore()
        rightpass = 0
        if let currentUser = UserManager.shared.currentUser{
            db.collection("users").document(currentUser.id).getDocument{ snapshot, err in
                if let user = User(id: snapshot?.documentID ?? "", data: snapshot?.data() ?? ["username":""]){
                    rightpass = user.password
                }
            }
        }
    }
    func submit(){
        passmatch = false
        wrongpass  = false
        let db = Firestore.firestore()
        if password.hash == rightpass{
            print("Yes")
            if newpass.hash == confirmnewwpass.hash{
                if let currentUser = UserManager.shared.currentUser{
                    db.collection("users").document(currentUser.id).updateData([
                        "password" : newpass.hash
                      ])
                }
            }
            else{
                passmatch = true
            }
        }
        else{
            wrongpass = true
        }
        
    }
}

#Preview {
    ChangePasswordView()
}
