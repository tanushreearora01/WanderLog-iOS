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
    @State var username : String = ""
    @State var caption : String = ""
    @State var post : ImageData
    @State var image : UIImage =  UIImage(imageLiteralResourceName: "1")
    @State var isLiked = false
    @State var showComments = false
    @State var currentUser = UserManager.shared.currentUser
    @State private var path = ""
    private static let itemSize = CGSize(width: 300, height: 300)
    @Environment(\.displayScale) private var displayScale
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    @State var user : User = User(id: "", data: ["fullname" : "",
                                                 "username" : "",
                                                 "password" : 0,
                                                 "bio" : "",
                                                 "email" : ""])!
    
    var body: some View {
        VStack{
            NavigationLink{
                ProfileMapView(user: user)
            }
            label:{
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame( width: 40, height: 40)
                        .clipShape(Circle())
                    Text(post.username)
                    Text("\(post.location[0]), \(post.location[1])")
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
            HStack{
                Text(post.username)
                    .bold()
                Text(post.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
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
        if let currentUser = UserManager.shared.currentUser{
            db.collection("users").whereField("username", isEqualTo: post.username).getDocuments(){(QuerySnapshot, err) in
                for document in QuerySnapshot!.documents{
                    if let u = User (id:document.documentID, data: document.data()){
                        user = u
                    }
                }
            }
        }
    }
}

//#Preview {
//    PostView()
//}
