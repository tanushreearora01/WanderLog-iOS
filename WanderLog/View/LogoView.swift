//
//  LogoView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/24/24.
//

import SwiftUI

struct LogoView: View{
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
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

        
    }
}

#Preview {
    LogoView()
}
