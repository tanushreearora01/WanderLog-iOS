//
//  CommentsView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 4/2/24.
//

import SwiftUI

struct CommentsView: View {
//    @State var post : ImageData
    var body: some View {
        ScrollView{
            HStack{
                Text("post.username")
                    .bold()
                Text("post.caption")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
//            ForEach(post.comments){ comment in
//                Text(comment["comment"])
//            }
        }
        .padding()
        Spacer()
            
    }
}

#Preview {
    CommentsView()
}
