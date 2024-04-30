//
//  EditProfileView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/7/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct EditProfileView: View {
    @StateObject private var model = DataModel()
    @Environment(\.presentationMode) var presentationMode
    @State var currentUser = UserManager.shared.currentUser
    @State var profilePic : UIImage = UIImage(imageLiteralResourceName: "1")
    @State var name = ""
    @State var username = ""
    @State var bio = ""
    @State var password = ""
    @State var newpass = ""
    @State var confirmnewwpass = ""
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Image(uiImage: profilePic)
                        .resizable()
                        .frame( width: 100, height: 100)
                        .clipShape(Circle())
                }
                .padding(15)
                NavigationLink{
                    PhotoCollectionView(photoCollection: model.photoCollection, source:"profile")
                }label:{
                    Text("Edit Profile Picture")
                        .font(.title2)
                        .bold()
                }
                .padding(.bottom,50)
                HStack{
                    Text("Full Name")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Full Name", text: $name)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                HStack{
                    Text("Username")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Username", text: $username)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .disabled(true)
                }
                HStack{
                    Text("Bio")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Bio", text: $bio)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Spacer()
                    .frame(height: 20)
                HStack{
                    NavigationLink{
                        ChangePasswordView()
                    } label:{
                        Text("Change Password")
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                }
                Spacer()
                    .frame(height: 50)
                Button{
                    submit()
                    presentationMode.wrappedValue.dismiss()
                }label:{
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                Button{}label:{
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                }
                .buttonStyle(.bordered)
                    
            }
            .onAppear(){
                getUserData()
            }
        }
        .navigationTitle("Edit Profile")
        .padding()
        .task {
            await model.loadPhotos()
        }
    }
    func getUserData(){
        let db = Firestore.firestore()
        if let currentUser = UserManager.shared.currentUser{
            name = currentUser.fullname
            username = currentUser.username
            bio = currentUser.bio
            let firestoreRef = Storage.storage().reference()
            db.collection("users").document(currentUser.id).getDocument{ snapshot, err in
                if let user1 = User(id: snapshot?.documentID ?? "", data: snapshot?.data() ?? ["username":""]){
                    if user1.profilePicture != ""{
                        let profilePicPath = user1.profilePicture
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
    func submit(){
        let db = Firestore.firestore()
        if let currentUser = UserManager.shared.currentUser{
            UserManager.shared.updateUser(id: currentUser.id, username: currentUser.username, email: currentUser.email,  bio: bio, fullname: name)
            db.collection("users").document(currentUser.id).updateData([
                "fullname" : name,
                "bio" : bio
              ])
        }
        
    }
}

#Preview {
    EditProfileView()
}
