//
//  SearchView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/11/24.
//

import SwiftUI
import FirebaseFirestore
struct SearchView: View {
    @State var users = [User]()
    @State var searchTerm = ""
    
    var filteredUsers : [User]{
        return users.filter{$0.username.localizedCaseInsensitiveContains(searchTerm)}
    }
    var body: some View {
        NavigationStack{
            List(filteredUsers){ user in
                HStack{
                    NavigationLink{
                        ProfileMapView(user: user)
                    }
                    label:{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.trailing, 10)
                        VStack{
                            Text("\(user.fullname)")
                            
                            Text("\(user.username)")
                                .foregroundStyle(.secondary)
                        }
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding(7)
            }
            .searchable(text: $searchTerm, prompt: "Search Users" )
        }
        .task { getUsers() }
        .navigationTitle("Search")
        
    }
    func getUsers(){
        self.users = []
        let db = Firestore.firestore()
        if let currentUser = UserManager.shared.currentUser{
            db.collection("users").whereField("username", isNotEqualTo: currentUser.id).getDocuments(){(querySnapshot,err) in
                if let err = err{ //error not nil
                    print("Error getting documents: \(err)")
                }
                else{ //get users from db
                    for document in querySnapshot!.documents{
                        if let user = User(id:document.documentID, data: document.data()){
                            users.append(user)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
