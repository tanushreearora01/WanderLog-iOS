//
//  Followers.swift
//  WanderLog
//
//  Created by Tanushree Arora on 3/25/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SwiftUIView: View {
    @State private var followingUsernames: [String] = []
    @State private var following = [String]()
    @State private var usernamesCount: Int = 0
    let db = Firestore.firestore()

    var body: some View {
        
        NavigationView {
            List(followingUsernames, id: \.self) { username in
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 10)
                    
                    Text(username)
                        .padding(.leading, 10)
                        
                    
                    Spacer()
                    
                    Button(action: {
                        // need to implement follow/unfollow functionality here
                    })
                    {
                        Text("Following")
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(radius: 1, x: 1, y: 1)
                    }
                    .padding(.bottom, 5)
                }
            }
            .navigationTitle("Following (\(usernamesCount))")
            .onAppear {
                getFollowing()
                fetchFollowingUsernames()
            }
        }
    }
    
    func fetchFollowingUsernames() {
        print(following)
        db.collection("connections").getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in QuerySnapshot!.documents{
                    if let user = User (id:document.documentID, data: document.data()){
                        for userid in following{
                            print(userid)
                            if user.id == userid{
                                print(user.username)
                                followingUsernames.append(user.username)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getFollowing(){
//        if let currentUser = UserManager.shared.currentUser{
//            print("Logged In")
//            
            db.collection("connections").getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
//                        print("\(document.documentID)")
                        if let connection = Connections (id:document.documentID, data: document.data()){
//                            print("\(connection)")
                            if(connection.userID1 == "aPMlTRvzUVv1TNCI30cL"){
                                print(connection.userID1)
                                following.append(connection.userID2)
                            }
                        }
                    }
                }
            }
//        }
//            else{
//                print("Not logged in")
//            }
        
    }
    
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

