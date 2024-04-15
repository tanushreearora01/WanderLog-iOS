//
//  CameraView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//
//Got this code from Apple Tutorials from https://developer.apple.com/tutorials/sample-apps/capturingphotos-camerapreview
import SwiftUI

struct CameraView: View {
    @StateObject private var model = DataModel()
    @State private var closed = false
    @State private var photoTaken = false
    private static let barHeightFactor = 0.15
    @StateObject var viewModel = LocationViewController()
    
    var body: some View {
       
        ZStack{
            NavigationStack {
                GeometryReader { geometry in
                    VStack{
                        if viewModel.isLocationChanged {
                                                    Text("Location Updated: \(viewModel.userLocation?.coordinate.latitude ?? 0), \(viewModel.userLocation?.coordinate.longitude ?? 0)")
                                                }
                    }
                    ViewfinderView(image:  $model.viewfinderImage )
                        .overlay(alignment: .topTrailing){
                            closeButtonView()
                        }
                        
                        .overlay(alignment: .bottom) {
                            buttonsView()
                                .frame(height: geometry.size.height * Self.barHeightFactor)
                                .background(.black.opacity(0.75))
                        }
                        .overlay(alignment: .center)  {
                            Color.clear
                                .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                .accessibilityElement()
                                .accessibilityLabel("View Finder")
                                .accessibilityAddTraits([.isImage])
                        }
                        .background(.black)
                }
                .task {
                    await model.camera.start()
                    await model.loadPhotos()
                    await model.loadThumbnail()
                }
                .navigationTitle("Camera")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .ignoresSafeArea()
                .statusBar(hidden: true)
                .onAppear {
                            viewModel.isLocationChanged = false
                               }
            }
            Text("Latitude: \(viewModel.userLocation?.coordinate.latitude ?? 0), Longitude: \(viewModel.userLocation?.coordinate.longitude ?? 0)")
        }
    }
    
    private func buttonsView() -> some View {
        HStack(spacing: 60) {
            
            Spacer()
            
            NavigationLink {
                PhotoCollectionView(photoCollection: model.photoCollection)
                    .onAppear {
                        model.camera.isPreviewPaused = true
                    }
                    .onDisappear {
                        model.camera.isPreviewPaused = false
                    }
            } label: {
                Label {
                    Text("Gallery")
                } icon: {
                    ThumbnailView(image: model.thumbnailImage)
                }
            }
            NavigationLink (destination:PhotoCollectionView(photoCollection: model.photoCollection),isActive: $photoTaken){
                Button {
                    model.camera.takePhoto()
                    photoTaken = true
                } label: {
                    Label {
                        Text("Take Photo")
                    } icon: {
                        ZStack {
                            Circle()
                                .strokeBorder(.white, lineWidth: 3)
                                .frame(width: 60, height: 62)
                            Circle()
                                .fill(.white)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            Button {
                model.camera.switchCaptureDevice()
            } label: {
                Label("Switch Camera", systemImage: "arrow.triangle.2.circlepath")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
        
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }
    private func closeButtonView() -> some View {
        HStack() {
            Spacer()
            NavigationLink(destination: NavBarUI(tabViewSelection: 0)){
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        .padding(.top,50)
        .padding(.trailing,30)
    }
    
    if et checkAuth = await viewModel.checkLocationAuthorization()
}

#Preview {
    CameraView()
}
