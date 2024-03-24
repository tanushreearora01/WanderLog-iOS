//
//  FullLogoView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/24/24.
//

import SwiftUI

struct FullLogoView: View{
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        if colorScheme == .light {
            Image("full-white")
                .resizable()
                .scaledToFit()
        } else {
            Image("full-black")
                .resizable()
                .scaledToFit()
        }

        
    }
}

#Preview {
    FullLogoView()
}
