//
//  Followers.swift
//  WanderLog
//
//  Created by Tanushree Arora on 3/25/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Following: View {
    @State private var followingUsernames = [User]()
    @State var following : [String]
    let db = Firestore.firestore()

    var body: some View {
        
        VStack{
            Text("Following (\(following.count))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            Divider()
            ForEach(followingUsernames) { user in
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 10)
                    NavigationLink{
                        ProfileMapView(user: user)
                    }label:{
                        Text("\(user.username)")
                    }
                    .foregroundStyle(.primary)
                    Spacer()
                    
                    Button(action: {
                        // need to implement remove follower functionality here
                    })
                    {
                        Text("Following")
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.primary)
                }
                .padding(5)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            fetchFollowingUsernames()
        }
        
    }
    
    
    func fetchFollowingUsernames() {
        followingUsernames = []
        db.collection("users").getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in QuerySnapshot!.documents{
                    if let user = User (id:document.documentID, data: document.data()){
                        for userid in following{
                            if user.id == userid{
                                followingUsernames.append(user)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    
    
}

#Preview {
    Following(following: ["7kDiwlNbTcb5v1inGNIa"])
}

