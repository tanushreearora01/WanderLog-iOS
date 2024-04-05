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
    @State var user : User
    @State var selfProfile : Bool
    @Environment(\.colorScheme) var colorScheme
    let db = Firestore.firestore()
    @State private var showPhotos = false
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
                    Text("@ \(user.username)")
                        .font(.title3)
                        .bold()
                    if selfProfile{
                        Menu {
                            NavigationLink(destination: LoginView(), isActive: $logoutSuccess){}
                            Button( action:{
                                UserManager.shared.logout()
                                logoutSuccess = true
                                
                            } ,label:{
                                Text("Logout")
                            })
                        } label: {
                            if (colorScheme == .light){
                                Label("",systemImage: "gearshape.fill")
                                    .foregroundColor(.black)
                            }
                            else{
                                Label("",systemImage: "gearshape.fill")
                                    .foregroundColor(.white)
                            }
                        }
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
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer().frame(width: 15)
                    NavigationLink{
                        Following(following: following)
                    } label:{
                        Text("\(following.count)\nFollowing")
                            .multilineTextAlignment(.center)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .fixedSize(horizontal: false, vertical: true)
                
                HStack{
                    Text(user.fullname)
                    Spacer()
                }
                HStack{
                    Text(user.bio)
                    Spacer()
                }
                NavigationStack{
                    
                    Button{
                        showPhotos = true
                    }label:{
                        Text("Show Photos")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                }
                .navigationDestination(isPresented: $showPhotos) {
                    ProfileGridView(user:user)
                }
                if selfProfile{
                    NavigationStack{
                        Button{
                            showPhotos = true
                        }label:{
                            Text("Edit Profile")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.gray)
                        .controlSize(.regular)
                        
                    }
                }
                else{
                    NavigationStack{
                        Button{
//                            showPhotos = true
                        }label:{
                            Text("Follow")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                        
                    }
                }
            }
            .onAppear(){
                getFollowing()
                getFollowers()
                checkUser()
            }
        }
        
    }
    func checkUser(){
        if let currentUser = UserManager.shared.currentUser{
            if user.id == currentUser.id{
                selfProfile = true
            }
        }
    }
    func getPostCount(){
        var count = 0
        print("Logged In")
        db.collection("posts").whereField("userID", isEqualTo: user.id).getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                for document in QuerySnapshot!.documents{
                    count = count+1
                }
                
            }
        }
    }
    func getFollowing(){
        self.following=[]
        print("Logged In")
        db.collection("connections").whereField("userID1", isEqualTo: user.id).getDocuments(){(QuerySnapshot, err) in
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
    func getFollowers(){
        self.followers=[]
        db.collection("connections").whereField("userID2", isEqualTo: user.id).getDocuments(){(QuerySnapshot, err) in
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
}

//#Preview {
//    ProfileView()
//}
