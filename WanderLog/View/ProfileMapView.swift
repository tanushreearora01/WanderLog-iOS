//
//  ProfileMapView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI

struct ProfileMapView: View {
    @State private var progress = 0.7
    @State private var showPhotos = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
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
                .tint(.black)
                .controlSize(.regular)
                NavigationStack{
                
                    Button{
                        showPhotos = true
                        print("Hello")
                    }label:{
                        Text("Show Photos")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.black)
                    .controlSize(.regular)
                }
                .navigationDestination(isPresented: $showPhotos) {
                                 ProfileGridView()
                             }
                
                
                
                
                Divider()
            }                
            .padding()
            GlobeView()
            ProgressView(value: progress)
                .padding()
                
            Spacer().frame(height: 30)
        }
        
        
    }
}

#Preview {
    ProfileMapView()
}
