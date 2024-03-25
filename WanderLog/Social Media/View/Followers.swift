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
    @State private var followingUsernames = [String]()
    @State private var following = [String]()
    @State private var usernamesCount = 0
    let db = Firestore.firestore()

    var body: some View {
        
        VStack{
            Text("Following (\(usernamesCount))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()

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
            .scrollContentBackground(.hidden)
        }
        .padding()
        .onAppear {
            getFollowing()
        }
        
    }
    
    
    func fetchFollowingUsernames() {
        print("following")
        db.collection("users").getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in QuerySnapshot!.documents{
                    if let user = User (id:document.documentID, data: document.data()){
                        for userid in following{
                            print("Following"+userid)
                            if user.id == userid{
                                print(user.username)
                                followingUsernames.append(user.username)
                                usernamesCount+=1
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func getFollowing(){
        if let currentUser = UserManager.shared.currentUser{
            print("Logged In")
            
            db.collection("connections").getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
                        if let connection = Connections (id:document.documentID, data: document.data()){
                            if(connection.userID1 == currentUser.id){
                                print("Step1 :",connection.userID1)
                                following.append(connection.userID2)
                            }
                        }
                    }
                    fetchFollowingUsernames()
                    
                }
            }
        }
        else{
            print("Not logged in")
        }
        
    }
    
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

