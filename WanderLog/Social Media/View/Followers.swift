//
//  Followers.swift
//  WanderLog
//
//  Created by Tanushree Arora on 3/25/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Followers: View {
    @State private var followerUsernames = [User]()
    @State var follower : [String]
    let db = Firestore.firestore()

    var body: some View {
        
        VStack{
            Text("Followers (\(follower.count))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            Divider()
            ForEach(followerUsernames) { user in
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
                        Text("Remove")
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
            fetchfollowerUsernames()
        }
        
    }
    
    
    func fetchfollowerUsernames() {
        followerUsernames = []
        db.collection("users").getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in QuerySnapshot!.documents{
                    if let user = User (id:document.documentID, data: document.data()){
                        for userid in follower{
                            if user.id == userid{
                                followerUsernames.append(user)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    
    
}

#Preview {
    Followers(follower: ["7kDiwlNbTcb5v1inGNIa"])
}

