//
//  PhotoCollectionView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/21/24.
//
//Got this code from Apple Tutorials from https://developer.apple.com/tutorials/sample-apps/capturingphotos-camerapreview
import SwiftUI
import os.log

struct PhotoCollectionView: View {
    @ObservedObject var photoCollection : PhotoCollection
    @State var source : String = "camera"
    @Environment(\.displayScale) private var displayScale
        
    private static let itemSpacing = 1.0
    private static let itemCornerRadius = 0.0
    private static let itemSize = CGSize(width: 120, height: 120)
    
    private var imageSize: CGSize {
        return CGSize(width: Self.itemSize.width * min(displayScale, 2), height: Self.itemSize.height * min(displayScale, 2))
    }
    
    private let columns = [GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5),GridItem(.flexible(),spacing:5)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(photoCollection.photoAssets) { asset in
                    NavigationLink {
                        PhotoView(source: source, asset: asset, cache: photoCollection.cache)
                    } label: {
                        photoItemView(asset: asset)
                    }
                    .buttonStyle(.borderless)
                    .accessibilityLabel(asset.accessibilityLabel)
                }
            }
            .padding([.vertical], Self.itemSpacing)
        }
        .navigationTitle(photoCollection.albumName ?? "Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .statusBar(hidden: false)
    }
    
    private func photoItemView(asset: PhotoAsset) -> some View {
        PhotoItemView(asset: asset, cache: photoCollection.cache, imageSize: imageSize)
            .frame(width: Self.itemSize.width, height: Self.itemSize.height)
            .clipped()
            .cornerRadius(Self.itemCornerRadius)
            .overlay(alignment: .bottomLeading) {
                if asset.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 1)
                        .font(.callout)
                        .offset(x: 4, y: -4)
                }
            }
            .onAppear {
                Task {
                    await photoCollection.cache.startCaching(for: [asset], targetSize: imageSize)
                }
            }
            .onDisappear {
                Task {
                    await photoCollection.cache.stopCaching(for: [asset], targetSize: imageSize)
                }
            }
    }
}

