//
//  EditProfileView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/7/24.
//

import SwiftUI

struct EditProfileView: View {
    @State var currentUser = UserManager.shared.currentUser
    @State var name = ""
    @State var username = ""
    @State var bio = ""
    @State var password = ""
    @State var newpass = ""
    @State var confirmnewwpass = ""
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame( width: 100, height: 100)
                        .clipShape(Circle())
                }
                .padding(15)
                NavigationLink{
                    
                }label:{
                    Text("Edit Profile Picture")
                        .font(.title2)
                        .bold()
                }
                .padding(.bottom,50)
                HStack{
                    Text("Full Name")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Full Name", text: $name)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                HStack{
                    Text("Username")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Username", text: $username)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .disabled(true)
                }
                HStack{
                    Text("Bio")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Bio", text: $bio)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
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
            .onAppear(){
                getUserData()
            }
        }
        .navigationTitle("Edit Profile")
        .padding()
    }
    func getUserData(){
        if let currentUser = UserManager.shared.currentUser{
            name = currentUser.fullname
            username = currentUser.username
            bio = currentUser.bio
//            password = currentUser.
        }
    }
    func submit(){
        
    }
}

#Preview {
    EditProfileView()
}
