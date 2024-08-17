//
//  ContentView.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                            .frame(height: 44)
                            .background(BackgroundEllipse())
                    }
                
                Text("Categories")
                    .tabItem {
                        Label("Categories", systemImage: "list.bullet")
                            .frame(height: 44)
                            .background(BackgroundEllipse())
                    }
                
                Text("Cart")
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                            .frame(height: 44)
                            .background(BackgroundEllipse())
                    }
                
                Text("Offers")
                    .tabItem {
                        Label("Offers", systemImage: "tag")
                            .frame(height: 44)
                            .background(BackgroundEllipse())
                    }
                
                Text("Account")
                    .tabItem {
                        Label("Account", systemImage: "person")
                            .frame(height: 44)
                            .background(BackgroundEllipse())
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

struct BackgroundEllipse: View {
    var body: some View {
        Ellipse()
            .fill(Color.blue.opacity(0.2))
            .frame(height: 44)
    }
}

struct SearchBar: UIViewRepresentable {
    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: SearchBar
        
        init(parent: SearchBar) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.searchText = searchText
        }
    }
    
    @Binding var searchText: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        searchBar.barTintColor = .white
        searchBar.tintColor = .black
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
            textField.textColor = .black
        }
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }
}


struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if !viewModel.banners.isEmpty {
                    BannerSliderView(banners: viewModel.banners)
                }
                
                if let bannerSingle = viewModel.bannerSingle {
                    if let urlString = bannerSingle.imageUrl, let url = URL(string: urlString) {
                        AsyncImage(url: url)
                            .frame(height: 150)
                            .clipped()
                            .padding(.horizontal)
                    }
                }
                
                if !viewModel.categories.isEmpty {
                    CategoriesView(categories: viewModel.categories)
                }
                
                if !viewModel.products.isEmpty {
                    ProductsView(products: viewModel.products)
                }
            }
        }
        .navigationTitle("E-Commerce")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ProductsView: View {
    var products: [Content.ContentDetail]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(products) { product in
                    VStack {
                        if let urlString = product.productImage, let url = URL(string: urlString) {
                            AsyncImage(url: url)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Text(product.productName ?? "")
                            .font(.caption)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                        Text(product.actualPrice ?? "")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        if let offerPrice = product.offerPrice, product.actualPrice != offerPrice {
                            Text(offerPrice)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        if let discount = product.discount, discount != "0% Off" {
                            Text(discount)
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BannerSliderView: View {
    var banners: [Content.ContentDetail]
    
    var body: some View {
        TabView {
            ForEach(banners) { banner in
                if let urlString = banner.imageUrl, let url = URL(string: urlString) {
                    AsyncImage(url: url)
                        .frame(height: 200)
                        .clipped()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
    }
}

struct CategoriesView: View {
    var categories: [Content.ContentDetail]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories) { category in
                    VStack {
                        if let urlString = category.imageUrl, let url = URL(string: urlString) {
                            AsyncImage(url: url)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                        Text(category.title ?? "")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
