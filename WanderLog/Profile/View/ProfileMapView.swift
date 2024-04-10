//
//  ProfileMapView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 2/29/24.
//

import SwiftUI

struct ProfileMapView: View {
    @State var user : User
    @State private var selfProfile = false
    @State private var progress = 0.7
    @State private var showPhotos = false
    var body: some View {
        VStack{
            VStack{
                ProfileView(user: user, selfProfile: selfProfile)
                Divider()
            }                
            .padding()
            GlobeView(user: user)
            
            Spacer()
        }
        .onAppear(){
            checkUser()
        }
        
    }
    func checkUser(){
        if let currentUser = UserManager.shared.currentUser{
            if user.id == currentUser.id{
                selfProfile = true
            }
        }
    }
}

//#Preview {
//    ProfileMapView()
//}
