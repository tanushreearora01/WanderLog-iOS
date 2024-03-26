//
//  HomeView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//

import SwiftUI


struct HomeView: View {
    var images: [String] = ["1","2","3","4","5","6","7"]
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
                    ForEach(images, id:\.self){ image in
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
                            Image(image)
                                .resizable()
                                .scaledToFit()
                            HStack{
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                Image(systemName: "bubble")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        }
                        
                    }
                    
                }
                
                    
            }
            .padding()
            .frame(maxWidth: .infinity)
            .onAppear(){
                getCurrentUser()
            }
        }
    }
    func getCurrentUser(){
        if let currentUser = UserManager.shared.currentUser {
            print("Showing profile for \(currentUser.username)")
            username = currentUser.username
        } else {
            print("No user is currently logged in.")
        }
    }
}

#Preview {
    HomeView()
}
