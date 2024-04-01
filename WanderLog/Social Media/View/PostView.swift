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
    @State private var username = "tarasha"
    @State private var caption = "Hello"
    @State var image : UIImage
    @State private var path = ""
    @State var images : [UIImage]
    @State var paths : [String]
    private static let itemSize = CGSize(width: 200, height: 200)
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
                Text(self.username)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            Image(uiImage: image)
                .resizable()
                .frame(width: Self.itemSize.width, height: Self.itemSize.height)
                .scaledToFit()
            HStack{
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                Image(systemName: "bubble")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            HStack{
                Text(username)
                    .bold()
                Text(caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
        .onAppear(){
            let x:Int = images.firstIndex(of: image)!
            path = paths[x]
            retrieveImage()
        }
    }
    func retrieveImage(){
        let db = Firestore.firestore()
        if let currentUser = UserManager.shared.currentUser{
            username = currentUser.username
            db.collection("posts").whereField("imageUrl", isEqualTo: path).getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
                        if let post = Posts(id:document.documentID, data: document.data()){
                            caption = post.content
                        }
                    }
                }
            }
        }
        else{
            print("Not logged in")
        }
    }
}

#Preview {
    PostView(image: UIImage(imageLiteralResourceName: "1"), images:[UIImage(imageLiteralResourceName: "1"),UIImage(imageLiteralResourceName: "2"),UIImage(imageLiteralResourceName: "3")],
    paths: ["","",""])
}
