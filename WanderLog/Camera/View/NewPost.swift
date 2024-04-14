//
//  NewPost.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/27/24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

struct NewPost: View {
    @State private var caption = ""
    @State private var city = ""
    @State private var country = ""
    @State var image: Image
    @State private var photoUploaded = false
    @StateObject var viewModel = PickerViewModel()
    
    var body: some View {
        VStack{
            image
                .resizable()
                .frame(height: 300)
                .scaledToFit()
            TextField("Write a caption", text: $caption, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5, reservesSpace: true)
            
            CountryCityPickerView(viewModel: <#T##PickerViewModel#>)
            
            Spacer()
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
        if let currentUser = UserManager.shared.currentUser,
           let coorinates = viewModel.coordinates  {
            print("Showing profile for \(currentUser.username)")
            let FirestoreRef = Storage.storage().reference()
            //convert image to data
            let uiImage: UIImage = self.image.asUIImage()
            let imageData = uiImage.jpegData(compressionQuality: 0.8)
            
            //check if image data is valid
            guard imageData != nil else{
                return
            }
            let path = "posts/\(currentUser.id)/\(UUID().uuidString).jpg"
            //specify file path and name
            let FileRef = FirestoreRef.child (path)
            
            //upload photo
            _ = FileRef.putData(imageData!, metadata: nil) { metadata, err in
                if err == nil{
                    let db = Firestore.firestore()
                    db.collection("posts").document().setData([
                        "userID" : currentUser.id,
                        "imageUrl" : path,
                        "content" : caption,
                        "location" : [coorinates.latitude, coordinates.longitude],
                        "likes" : [],
                        "comments" : [],
                    ])
                }
            }
        } else {
            print("No user is currently logged in.")
        }
    }
}

#Preview {
    NewPost(image: Image("1"))
}
