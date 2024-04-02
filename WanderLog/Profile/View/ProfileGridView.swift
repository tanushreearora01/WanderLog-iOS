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
    @State private var showMap = false
    @State private var navigate = false
    @State var posts = [ImageData]()
//    @State var currentUser = UserManager()
    //Hardcoding pictures list for now. Will make it dynamic after posting feature is implemented
    @State var images = [UIImage]()
    @State var paths = [String]()
    var columngrid:[GridItem] = [GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5)]
    private static let itemSize = CGSize(width: 120, height: 120)
    @Environment(\.displayScale) private var displayScale
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    
                    Button{
                        print("Back button pressed")
                        showMap = true
                    }label:{
                        
                        HStack{
                            Image(systemName: "chevron.backward")
                            Text("Back")
                            Spacer()
                        }
                        .foregroundStyle(.black)
                    }
                }
            }
            .padding()
            ScrollView{
                LazyVGrid(columns: columngrid, spacing: 5){
                    ForEach(posts){ post in
                        NavigationLink{
                            PostView(username: post.username, caption: post.caption, image: post.image)
                        }
                        label:{
                            Image(uiImage:post.image)
                                .resizable()
                                .frame(width: Self.itemSize.width, height: Self.itemSize.height)
                        }
                        
                    }
                    
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showMap) {
                         NavBarUI(tabViewSelection: 4)
                     }
        .onAppear(){
            retrieveImages()
        }
        
        
    }
    func retrieveImages(){
        paths = []
        images = []
        posts = []
        let db = Firestore.firestore()
        let firestoreRef = Storage.storage().reference()
        if let currentUser = UserManager.shared.currentUser{
            db.collection("posts").whereField("userID", isEqualTo: currentUser.id).getDocuments(){(QuerySnapshot, err) in
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
                                            posts.append((ImageData(id:post.id,d:["caption":post.content, "image": i, "username": currentUser.username ]) ?? ImageData(id: "", d: ["caption" : "","image" : UIImage(), "username":""]))!)
                                            images.append(i)
                                           
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
    ProfileGridView()
}
