//
//  ProfileGridView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI

struct ProfileGridView: View {
    var images: [String] = ["1","2","3","4","5","6","7"]
    var columngrid:[GridItem] = [GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5)]
    var body: some View {
        VStack{
            ProfileView()
            HStack{
                Button{
                    print("Back button pressed")
                }label:{
                    HStack{
                        Image(systemName: "chevron.backward")
                        Text("Back")
                        Spacer()
                    }
                    .foregroundStyle(.black)
                }
            }
            ScrollView{
                LazyVGrid(columns: columngrid, spacing: 5){
                    ForEach(images, id:\.self){ image in
                        Image(image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    ProfileGridView()
}
