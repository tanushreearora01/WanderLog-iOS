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
    @State private var followerUsernames = [String]()
    @State var follower : [String]
    let db = Firestore.firestore()

    var body: some View {
        
        VStack{
            Text("Followers (\(follower.count))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()

            List(followerUsernames, id: \.self) { username in
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 10)
                    
                    Text(username)
                        .padding(.leading, 10)
                        
                    
                    Spacer()
                    
                    Button(action: {
                        // need to implement remove follower functionality here
                    })
                    {
                        Text("Remove")
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
            fetchfollowerUsernames()
        }
        
    }
    
    
    func fetchfollowerUsernames() {
        db.collection("users").getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in QuerySnapshot!.documents{
                    if let user = User (id:document.documentID, data: document.data()){
                        for userid in follower{
                            if user.id == userid{
                                followerUsernames.append(user.username)
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    
    
}

#Preview {
    Followers(follower: [""])
}

