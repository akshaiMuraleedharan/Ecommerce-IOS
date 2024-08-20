//
//  DashboardView.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 19/08/24.
//

import SwiftUI

struct DashboardView: View {
    @State private var searchText = ""
    
    var body: some View {
        ContentView() // Integrate ContentView into DashboardView
            .navigationBarItems(leading: cartButton, trailing: notificationButton)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchBar(searchText: $searchText)
                        .frame(width: 280)
                }
            }
    }
    
    var cartButton: some View {
        Button(action: {
            // Action for cart button
        }) {
            Image("cartLogo")
                .foregroundColor(.black)
        }
    }
    
    var notificationButton: some View {
        Button(action: {
            // Action for notification button
        }) {
            ZStack {
                Image(systemName: "bell")
                    .foregroundColor(.white)
                
                Text("3")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Circle().fill(Color.red))
                    .offset(x: 12, y: -12)
            }
        }
    }
}

#Preview {
    DashboardView()
}
