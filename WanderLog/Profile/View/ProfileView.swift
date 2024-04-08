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
    @State var followingUser = false
    @Environment(\.colorScheme) var colorScheme
    let db = Firestore.firestore()
    @State private var postCount = 0
    @State private var showPhotos = false
    @State private var logoutSuccess =  false
    @State private var showPopOver =  false
    @State private var following = [String]()
    @State private var followers = [String]()
    @State private var remove = false
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
                            Label("",systemImage: "gearshape.fill")
                                .foregroundColor(.primary)
                        }
                    }
                    
                }
                
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame( width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                    Spacer().frame(width: 20)
                    Text("\(postCount)\nPosts")
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
                NavigationLink{
                    ProfileGridView(user:user)
                }label: {
                    Text("Show Photos")
                        .frame(maxWidth: .infinity)
                        
                }
                .buttonStyle(.borderedProminent)
                if selfProfile{
                    NavigationLink{
                        EditProfileView()
                    }label: {
                        Text("Edit Profile")
                            .frame(maxWidth: .infinity)
                            
                            
                    }
                    .foregroundStyle(.primary)
                    .buttonStyle(.bordered)
                }
                else{
                    if followingUser{
                        Button{
                            remove = true
                        }label:{
                            Text("Following")
                                .frame(maxWidth: .infinity)
                            
                        }
                        .foregroundStyle(.primary)
                        .buttonStyle(.bordered)
                        .controlSize(.regular)
                            
                    }
                    else{
                        Button{
                            follow()
                        }label:{
                            Text("Follow")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                    }
                }
                
            }
            .confirmationDialog("Unfollow \(user.username)?", isPresented: $remove) {
                Button {
                    unfollow()
                } label: {
                    Text("Unfollow")
                }
                Button("Cancel", role: .cancel) {}
            }
            .onAppear(){
                getFollowing()
                getFollowers()
                checkUser()
                getPostCount()
            }
        }
        
    }
    func unfollow(){
        let currentUser = UserManager.shared.currentUser
        db.collection("connections").whereField("userID2", isEqualTo: user.id).whereField("userID1", isEqualTo: currentUser?.id ?? "").getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                for document in QuerySnapshot!.documents{
                    db.collection("connections").document(document.documentID).delete()
                }
                
            }
        }
        followingUser = false
    }
    func follow(){
        let currentUser = UserManager.shared.currentUser
        let data = ["userID1": currentUser?.id ?? "",
                    "userID2": user.id] as [String:Any]
        var ref: DocumentReference? = nil
        //Add entry to db
        ref = db.collection("connections")
            .addDocument(data: data){ err in
                if let err = err{
                    print("Error in adding doc \(err)")
                }
                else{
                    print("Document added with ID : \(ref!.documentID)")
                    getFollowers()
                    followingUser = true
                }
            }
    }
    func checkUser(){
        if let currentUser = UserManager.shared.currentUser{
            if user.id == currentUser.id{
                selfProfile = true
            }
            else{
                selfProfile = false
                db.collection("connections").whereField("userID2", isEqualTo: user.id).whereField("userID1", isEqualTo: currentUser.id).getDocuments(){(QuerySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    }
                    else {
                        for document in QuerySnapshot!.documents{
                            if Connections (id:document.documentID, data: document.data()) != nil{
                                followingUser = true
                            }
                        }
                        
                    }
                }
            }
        }
    }
    func getPostCount(){
        db.collection("posts").whereField("userID", isEqualTo: user.id).getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                postCount = QuerySnapshot!.documents.count
            }
        }
    }
    func getFollowing(){
        self.following=[]
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
