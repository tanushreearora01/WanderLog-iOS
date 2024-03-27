//
//  PhotoView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/21/24.
//
//Got this code from Apple Tutorials from https://developer.apple.com/tutorials/sample-apps/capturingphotos-camerapreview
import SwiftUI
import Photos
import FirebaseStorage

struct PhotoView: View {
    var asset: PhotoAsset
    var cache: CachedImageManager?
    @State private var photoUploaded = false
    @State var image: Image?
    @State private var imageRequestID: PHImageRequestID?
    @Environment(\.dismiss) var dismiss
    private let imageSize = CGSize(width: 1024, height: 1024)
    
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel(asset.accessibilityLabel)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.black)
        .overlay(alignment: .topTrailing) {
            buttonsView()
                .offset(x:0,y:0)
        }
        .task {
            guard image == nil, let cache = cache else { return }
            imageRequestID = await cache.requestImage(for: asset, targetSize: imageSize) { result in
                Task {
                    if let result = result {
                        self.image = result.image
                    }
                }
            }
        }
    }
    
    private func buttonsView() -> some View {
        HStack(spacing: 60) {
            NavigationLink(destination: NewPost(image: image ?? Image("1"))){
                Text("Next")
            }
        }
    }
}

