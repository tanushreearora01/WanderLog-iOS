//
//  CheckBoxView.swift
//  WanderLog
//
//  Created by Tarasha Bansal on 3/6/24.
//
import SwiftUI
import FirebaseFirestore

struct CheckBoxView: View {
    @State var location : Locations
    var body: some View {
        HStack{
            if location.visited{
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        location.visited.toggle()
                        uncheck()
                    }
            }
            else{
                Image(systemName: "checkmark.circle")
                    .onTapGesture {
                        location.visited.toggle()
                        check()
                    }
            }
            Text("\(location.city),\(location.country)")
            Spacer()
        }
        .padding(.bottom,5)
    }
    func check(){
        let db = Firestore.firestore()
        db.collection("locations").document(location.id).updateData([
            "visited": true
          ])
    }
    func uncheck(){
        let db = Firestore.firestore()
        db.collection("locations").document(location.id).updateData([
            "visited": false
          ])
    }
}




