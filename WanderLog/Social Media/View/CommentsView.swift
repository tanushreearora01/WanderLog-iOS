//
//  CommentsView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/2/24.
//

import SwiftUI
import FirebaseFirestore

struct CommentsView: View {
    @State var post : ImageData
    @State private var comment = ""
    
    var body: some View {
        VStack{
            ScrollView{
                Text("Comments")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                Divider()
                HStack{
                    Text("\(post.username)")
                        .bold()
                    Text("\(post.caption)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                ForEach(post.comments, id:\.self){ comment in
                    HStack{
                        Text("\(comment["username"] ?? "")")
                            .bold()
                        Text("\(comment["comment"] ?? "")")
                    }
                    .padding(.bottom,10)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                }
            }
            Spacer()
            HStack{
                TextField("Add comment...", text: $comment)
                    .textFieldStyle(.roundedBorder)
                Button( action:{
                    postComment()
                } ,label:{
                    Text("Post")
                })
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .padding()
        Spacer()
    }

    func postComment(){
        let db = Firestore.firestore()
        if let currentUser = UserManager.shared.currentUser{
            let newComment = ["comment":comment, "username":currentUser.username]
            post.comments.append(newComment)
            db.collection("posts").document(post.id).updateData(["comments":FieldValue.arrayUnion([newComment])])
            comment = ""
        }
    }
}
//
//#Preview {
//    CommentsView()
//}
