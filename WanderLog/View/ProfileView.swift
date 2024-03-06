//
//  ProfileView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI
import MapKit


struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            HStack{
                
                if colorScheme == .light {
                    Image("text-white")
                        .resizable()
                        .frame(width: 100, height: 50)
                } else {
                    Image("text-black")
                        .resizable()
                        .frame(width: 100, height: 50)
                        .onAppear(){
                            
                        }
                }
                Spacer()
                Text("@tarasha.bansal")
                    .font(.title3)
                    .bold()
            }
            
            HStack{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame( width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .clipShape(Circle())
                Spacer().frame(width: 20)
                Text("100\nPosts")
                    .multilineTextAlignment(.center)
                Spacer().frame(width: 20)
                Text("100\nFollowers")
                    .multilineTextAlignment(.center)
                Spacer().frame(width: 20)
                Text("100\nFollowing")
                    .multilineTextAlignment(.center)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            HStack{
                Text("Tarasha Bansal")
                Spacer()
            }
            HStack{
                Text("Geez!")
                Spacer()
            }
            Button(action:{
                print("Hello")
            }){
                Text("Edit Profile")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.white)
            .controlSize(.regular)
            
            
            
            Divider()
        }
    }
        
    
}

#Preview {
    ProfileView()
}
