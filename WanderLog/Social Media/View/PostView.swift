//
//  PostView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/27/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore


struct PostView: View {
    @State var profilePic : UIImage = UIImage(imageLiteralResourceName: "1")
    @State var post : ImageData
    @State var isLiked = false
    @State var showComments = false
    @State var currentUser = UserManager.shared.currentUser
    private static let itemSize = CGSize(width: 300, height: 300)
    @Environment(\.displayScale) private var displayScale
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    @State var user : User = User(id: "", data: ["fullname" : "",
                                                 "username" : "",
                                                 "password" : 0,
                                                 "bio" : "",
                                                 "email" : "",
                                                 "profilePicture" : ""])!
    
    var body: some View {
        VStack{
            NavigationLink{
                ProfileMapView(user: user)
            }
            label:{
                HStack{
                    Image(uiImage: profilePic)
                        .resizable()
                        .frame( width: 40, height: 40)
                        .clipShape(Circle())
                    VStack (alignment: .leading){
                        Text(post.username)
                        if post.location[0] != ""{
                            Text("\(post.location[0]), \(post.location[1])")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            }
            .foregroundStyle(.primary)
            Image(uiImage: post.image)
                .resizable()
                .frame(width: Self.itemSize.width, height: Self.itemSize.height)
                .scaledToFit()
            HStack{
                if isLiked{
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.red)
                        .onTapGesture {
                            isLiked = false
                            let x = post.likes.firstIndex(of: currentUser?.id ?? "")
                            post.likes.remove(at: x ?? -1)
                            removeLikes()
                        }
                }
                else{
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            isLiked = true
                            post.likes.append(currentUser?.id ?? "")
                            updateLikes()
                        }
                }
                Text("\(post.likes.count)")
                Image(systemName: "bubble")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        showComments = true
                    }
                    .sheet(isPresented: $showComments, content: {
                        CommentsView(post: post)
                    })
                    
                Text("\(post.comments.count)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            if post.caption != ""{
                HStack{
                    Text(post.username)
                        .bold()
                    Text(post.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .onAppear(){
            liked()
            getUser()
        }
    }
    func liked(){
        if let currentUser = UserManager.shared.currentUser{
            if post.likes.contains(currentUser.id){
                isLiked = true
            }
        }
    }
    func updateLikes(){
        let db = Firestore.firestore()
        db.collection("posts").document(post.id).updateData(["likes":FieldValue.arrayUnion([currentUser?.id ?? ""])])
    }
    func removeLikes(){
        let db = Firestore.firestore()
        db.collection("posts").document(post.id).updateData(["likes":FieldValue.arrayRemove([currentUser?.id ?? ""])])
    }
    func getUser(){
        let db = Firestore.firestore()
        let firestoreRef = Storage.storage().reference()
        if UserManager.shared.currentUser != nil{
            db.collection("users").whereField("username", isEqualTo: post.username).getDocuments(){(QuerySnapshot, err) in
                for document in QuerySnapshot!.documents{
                    if let u = User (id:document.documentID, data: document.data()){
                        user = u
                        if u.profilePicture != ""{
                            let profilePicPath = user.profilePicture
                            let fileRef1 = firestoreRef.child(profilePicPath)
                            fileRef1.getData(maxSize: 5 * 1024 * 1024) { data, error in
                                if error ==  nil && data != nil{
                                    if let i1 = UIImage(data: data!){
                                        DispatchQueue.main.async{
                                            profilePic = i1
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
}

#Preview {
    PostView(post: ImageData(id:"jrJ7U2nGZfzELMMhEySN", d: ["username" : "tarasha", "location": ["LA","USA"], "caption":"..", "image":UIImage(imageLiteralResourceName: "1"),"likes":[], "comments":[]])!)
}
