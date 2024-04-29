//
//  ProfilePic.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/29/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

struct ProfilePic: View {
    @State var image: Image
    @State private var photoUploaded = false

    var body: some View {
        VStack{
            image
                .resizable()
                .frame(height: 300)
                .scaledToFit()
            
            NavigationLink(destination: NavBarUI(tabViewSelection: 0), isActive: $photoUploaded){}
            Button( action:{
                uploadPhoto()
                photoUploaded = true
            } ,label:{
                Text("Share")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            })
            .buttonStyle(.borderedProminent)
            .padding()
            
            
        }
        .padding()
        
        
    }
    func uploadPhoto(){
        if let currentUser = UserManager.shared.currentUser
        {
            print("Showing profile for \(currentUser.username)")
            let FirestoreRef = Storage.storage().reference()
            //convert image to data
            let uiImage: UIImage = self.image.asUIImage()
            let imageData = uiImage.jpegData(compressionQuality: 0.8)
            
            //check if image data is valid
            guard imageData != nil else{
                return
            }
            let path = "profile/\(currentUser.id).jpg"
            //specify file path and name
            let FileRef = FirestoreRef.child(path)
            
            //upload photo
            _ = FileRef.putData(imageData!, metadata: nil) { metadata, err in
                if err == nil{
                    let db = Firestore.firestore()
                    db.collection("users").document(currentUser.id).updateData([
                        "profilePicture" : path,
                    ])
                }
            }
        } else {
            print("No user is currently logged in.")
        }
    }
    
}

#Preview {
    ProfilePic(image: Image("1"))
}

