//
//  ViewfinderView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/21/24.
//
//Got this code from Apple Tutorials from https://developer.apple.com/tutorials/sample-apps/capturingphotos-camerapreview
import SwiftUI

struct ViewfinderView: View {
    @Binding var image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
//        Text("Hello")
    }
}

struct ViewfinderView_Previews: PreviewProvider {
    static var previews: some View {
        ViewfinderView(image: .constant(Image(systemName: "pencil")))
    }
}
