//
//  NavBarUI.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//

import SwiftUI
import FirebaseFirestore

struct NavBarUI: View {
    @State var user : User = User(id: "", data: ["fullname" : "",
                                                 "username" : "",
                                                 "password" : 0,
                                                 "bio" : "",
                                                 "email" : ""])!
    @State public var tabViewSelection : Int
//    @State public var currentUser : User
    var body: some View {
        NavigationStack{
            TabView(selection: $tabViewSelection){
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                BucketListView()
                    .tabItem {
                        Image(systemName: "basket")
                    }.tag(1)
                CameraView()
                    .tabItem {
                        Image(systemName: "camera")
                    }.tag(2)
                    .toolbar(.hidden, for: .tabBar)
                ProfileMapView(user : user)
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(3)
            }
            
            
        }
        .navigationBarHidden(true)
        .onAppear(){
            getUser()
        }
    }
    func getUser(){
        let db = Firestore.firestore()
        if let currentUser = UserManager.shared.currentUser{
            db.collection("users").document(currentUser.id).getDocument { snapshot, err in
                if let u = User(id: snapshot?.documentID ?? "", data: snapshot?.data() ?? ["username":""]){
                    user = u
                }
            }
        }
    }
}

#Preview {
    NavBarUI(tabViewSelection : 3)
}



