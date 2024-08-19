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
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                            .frame(height: 44)
                    }
                
                Text("Categories")
                    .tabItem {
                        Label("Categories", systemImage: "list.bullet")
                            .frame(height: 44)
                    }
                
                Text("Cart")
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                            .frame(height: 44)
                    }
                
                Text("Offers")
                    .tabItem {
                        Label("Offers", systemImage: "tag")
                            .frame(height: 44)
                    }
                
                Text("Account")
                    .tabItem {
                        Label("Account", systemImage: "person")
                            .frame(height: 44)
                    }
            }
            .navigationBarItems(leading: cartButton, trailing: notificationButton)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchBar(searchText: $searchText)
                        .frame(width: 280)
                }
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
                    .background(Circle().fill(Color.red))
                    .offset(x: 10, y: -10)
            }
        }
    }

}

#Preview {
    DashboardView()
}
