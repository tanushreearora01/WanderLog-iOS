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
    @State var posts = [ImageData]()
    @State var image : UIImage =  UIImage(imageLiteralResourceName: "1")
    @State private var path = ""
//    @State var images : [UIImage]
//    @State var paths : [String]
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
            
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    PostView()
}
