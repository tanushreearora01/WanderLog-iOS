//
//  InitialBucketList.swift
//  WanderLog
//
//  Created by Tanushree Arora on 4/14/24.
//

import SwiftUI

struct InitialBucketList: View {
    @State var city = ""
    @State var country = ""
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                LogoView()
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
                Text("Wanderlog")
                    .font(.largeTitle)
                Spacer()
                Text("Create a Bucket List to begin")
                    .font(.headline)
                    
                TextField("City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            
                    TextField("Country", text: $country)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                Button() {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add another Item")
                    }
                }
                .padding()
                Button("Sign Up") {
                    // Handle sign up action
                }
//                .buttonStyle(.borderedProminent)
                .padding()
                Spacer()
            }
        }
    }
    
    
}

struct InitialBucketList_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}

