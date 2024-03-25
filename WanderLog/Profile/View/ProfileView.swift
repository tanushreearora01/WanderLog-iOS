//
//  ProfileView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import MapKit
import FirebaseFirestore

struct ProfileView: View {
    let db = Firestore.firestore()
    @State private var showPhotos = false
    @State private var fullname =  ""
    @State private var username =  ""
    @State private var bio =  ""
    var body: some View {
        VStack{
            HStack{
                LogoView()
                Spacer()
                Text("@"+username)
                    .font(.title3)
                    .bold()
            }
            
            HStack{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame( width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .clipShape(Circle())
                Spacer().frame(width: 20)
                Text("100\nPosts")
                    .multilineTextAlignment(.center)
                Spacer().frame(width: 20)
                Text("100\nFollowers")
                    .multilineTextAlignment(.center)
                Spacer().frame(width: 20)
                Text("100\nFollowing")
                    .multilineTextAlignment(.center)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            HStack{
                Text(fullname)
                Spacer()
            }
            HStack{
                Text(bio)
                Spacer()
            }
            
            Button(action:{
                print("Hello")
            }){
                Text("Edit Profile")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.black)
            .controlSize(.regular)
            NavigationStack{
                
                Button{
                    showPhotos = true
                    print("Hello")
                }label:{
                    Text("Show Photos")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.black)
                .controlSize(.regular)
            }
            .navigationDestination(isPresented: $showPhotos) {
                ProfileGridView()
            }
            
            Divider()
        }
        .onAppear(){
            getCurrentUser()
        }
    }
    
    
    func getCurrentUser(){
        if let currentUser = UserManager.shared.currentUser {
            print("Showing profile for \(currentUser.username)")
            username = currentUser.username
            fullname = currentUser.fullname
            bio = currentUser.bio
        } else {
            print("No user is currently logged in.")
        }
    }
        
    
}

#Preview {
    ProfileView()
}
