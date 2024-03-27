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
    @State private var logoutSuccess =  false
    @State private var showPopOver =  false
    @State private var following = [String]()
    @State private var followers = [String]()
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    LogoView()
                    Spacer()
                    Text("@"+username)
                        .font(.title3)
                        .bold()
                    Menu {
                        NavigationLink(destination: LoginView(), isActive: $logoutSuccess){}
                        Button( action:{
                            UserManager.shared.logout()
                            logoutSuccess = true
                            
                        } ,label:{
                            Text("Logout")
                        })
                    } label: {
                        Label("",systemImage: "gearshape.fill")
                            .foregroundColor(.black)
                    }
                    
                }
                
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame( width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                    Spacer().frame(width: 20)
                    Text("100\nPosts")
                        .multilineTextAlignment(.center)
                    Spacer().frame(width: 15)
                    NavigationLink{
                        Followers(follower: followers)
                    } label:{
                        Text("\(followers.count)\nFollowers")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)
                    }
                    Spacer().frame(width: 15)
                    NavigationLink{
                        Following(following: following)
                    } label:{
                        Text("\(following.count)\nFollowing")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)
                    }
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
                NavigationStack{
                    Button{
                        showPhotos = true
                        print("Hello")
                    }label:{
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
                }
                .onAppear(){
//                    getCurrentUser()
                    getFollowing()
                    getFollowers()
                }
            }
        }
        
    }
    func getFollowing(){
        self.following=[]
        if let currentUser = UserManager.shared.currentUser{
            print("Logged In")
            username = currentUser.username
            bio = currentUser.username
            fullname = currentUser.fullname
            db.collection("connections").whereField("userID1", isEqualTo: currentUser.id).getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
                        if let connection = Connections (id:document.documentID, data: document.data()){
                            following.append(connection.userID2)
                        }
                    }
                    
                }
            }
        }
        else{
            print("Not logged in")
        }
        
    }
    func getFollowers(){
        self.followers=[]
        if let currentUser = UserManager.shared.currentUser{
            db.collection("connections").whereField("userID2", isEqualTo: currentUser.id).getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
                        if let connection = Connections (id:document.documentID, data: document.data()){
                                followers.append(connection.userID1)
                        }
                    }
                    
                }
            }
        }
        else{
            print("Not logged in")
        }
        
    }
    
    
}

#Preview {
    ProfileView()
}
