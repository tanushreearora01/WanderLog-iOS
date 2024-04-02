//
//  HomeView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Firebase

struct HomeView: View {
    @State var paths =  [String]()
    @State var images =  [UIImage]()
    @State var posts = [ImageData]()
    @State var following = [String]()

    var columngrid:[GridItem] = [GridItem(.flexible(),spacing:5)]
    @State private var username =  ""
    var body: some View {
        VStack{
            HStack{
                LogoView()
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            .padding()
            ScrollView{
                Text("Posts")
                    .font(.title)
                    .bold()
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                LazyVGrid(columns: columngrid, spacing: 5){
                    ForEach(posts){ post in
                        PostView(username:post.username,caption: post.caption,image:post.image)
                        
                    }
                    
                }
                
                
                    
            }
            .frame(maxWidth: .infinity)
            .onAppear(){
                getFollowing()
            }
        }
    }
    func getFollowing(){
        let db = Firestore.firestore()
        self.following=[]
        if let currentUser = UserManager.shared.currentUser{
            db.collection("connections").whereField("userID1", isEqualTo: currentUser.id).getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
                        if let connection = Connections (id:document.documentID, data: document.data()){
                            following.append(connection.userID2)
                        }
                    }
                    if following.count != 0{
                        retrieveImages()
                    }
                    
                }
            }
            
        }
        else{
            print("Not logged in")
        }
        
    }
    
    func retrieveImages(){
        posts = []
        var username1 = ""
        let db = Firestore.firestore()
        let firestoreRef = Storage.storage().reference()
        if UserManager.shared.currentUser != nil{
            db.collection("posts").whereField("userID", in: following).getDocuments(){(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in QuerySnapshot!.documents{
                        print(document)
                        if let post = Posts(id:document.documentID, data: document.data()){
                            db.collection("users").document(post.userID).getDocument { snapshot, err in
                                if let user = User(id: snapshot?.documentID ?? "", data: snapshot?.data() ?? ["username":""]){
                                    username1 = user.username
                                }
                            }
//                            print(user)
                            let path = post.imageUrl
                            let fileRef = firestoreRef.child(path)
                            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                                if error ==  nil && data != nil{
                                    if let i = UIImage(data: data!){
                                        DispatchQueue.main.async{
                                            posts.append((ImageData(id:post.id,d:["caption":post.content, "image": i, "username":username1 ]) ?? ImageData(id: "", d: ["caption" : "","image" : UIImage(),"username":""]))!)
                                           
                                        }
                                    }
                                }
                            }
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
    HomeView()
}
