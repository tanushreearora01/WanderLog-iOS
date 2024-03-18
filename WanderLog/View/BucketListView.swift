//
//  BucketListView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/2/24.
//

import SwiftUI
struct BucketList: Identifiable {
    let id = UUID()
    var city: String
    var country: String
    var visited: Bool
}

struct BucketListView: View {
//    @State private var checked : Bool = false
    @State private var locations: [BucketList] =
    [BucketList(city: "Paris", country:"France", visited: false),
     BucketList(city: "Istanbul", country:"Turkey", visited: false),
     BucketList(city: "Las Vegas", country:"USA", visited: false),
     BucketList(city: "Udaipur", country:"India", visited: true)]
    var body: some View {
        VStack{
            Text("Bucket List")
                .font(.largeTitle)
                .bold()
            Divider()
            ForEach(locations){ location in
                var checked = location.visited
                HStack{
                    Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            print("Tapped "+location.city)
                            checked.toggle()
                        }
                    Text(location.city+","+location.country)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

#Preview {
    BucketListView()
}
