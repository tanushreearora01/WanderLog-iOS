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
    @State private var path = ""
    private static let itemSize = CGSize(width: 300, height: 300)
    @Environment(\.displayScale) private var displayScale
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame( width: 40, height: 40)
                    .clipShape(Circle())
                Text(post.username)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
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
                }
                else{
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
                Text("\(post.likes.count)")
                Image(systemName: "bubble")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
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
        .padding()
        .onAppear(){
            liked()
        }
    }
    func liked(){
        if let currentUser = UserManager.shared.currentUser{
            if post.likes.contains(currentUser.id){
                isLiked = true
            }
//            print(currentUser.id)
//            print(post.likes)
        }
    }
}

//#Preview {
//    PostView()
//}
