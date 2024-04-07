//
//  ProfileGridView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ProfileGridView: View {
    @State var user : User
    @State var selfProfile = false
    @State private var showMap = false
    @State private var navigate = false
    @State var posts = [ImageData]()
    @State var paths = [String]()
    var columngrid:[GridItem] = [GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5)]
    private static let itemSize = CGSize(width: 120, height: 120)
    @Environment(\.displayScale) private var displayScale
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                if (posts.count == 0){
                    VStack{
                        Image(systemName: "camera.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("No posts yet")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                else{
                    LazyVGrid(columns: columngrid, spacing: 5){
                        ForEach(posts){ post in
                            NavigationLink{
                                PostView(post:post)
                            }
                        label:{
                            Image(uiImage:post.image)
                                .resizable()
                                .frame(width: Self.itemSize.width, height: Self.itemSize.height)
                        }
                            
                        }
                        
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Posts")
        .onAppear(){
            checkUser()
            retrieveImages()
        }
        
        
    }
    func checkUser(){
        if let currentUser = UserManager.shared.currentUser{
            if user.id == currentUser.id{
                selfProfile = true
            }
        }
    }
    func retrieveImages(){
        paths = []
        posts = []
        let db = Firestore.firestore()
        let firestoreRef = Storage.storage().reference()
        db.collection("posts").whereField("userID", isEqualTo: user.id).getDocuments(){(QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                for document in QuerySnapshot!.documents{
                    if let post = Posts(id:document.documentID, data: document.data()){
                        let path = post.imageUrl
                        let fileRef = firestoreRef.child(path)
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error ==  nil && data != nil{
                                if let i = UIImage(data: data!){
                                    DispatchQueue.main.async{
                                        posts.append((ImageData(id:post.id,d:["caption":post.content, "image": i, "username": user.username, "likes":post.likes, "comments":post.comments]) ?? ImageData(id: "", d: ["caption" : "","image" : UIImage(), "username":""]))!)
                                       
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ProfileGridView()
//}
