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
                
                if let bannerSingle = viewModel.bannerSingle,
                   let urlString = bannerSingle.imageURL,
                   let url = URL(string: urlString) {
                    AsyncImage(url: url)
                        .frame(height: 150)
                        .clipped()
                        .padding(.horizontal)
                }
                
                if !viewModel.categories.isEmpty {
                    CategoriesView(categories: viewModel.categories)
                }
                
                if !viewModel.products.isEmpty {
                    ProductsView(products: viewModel.products)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductsView: View {
    var products: [Content]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(products, id: \.sku) { product in
                    VStack {
                        if let urlString = product.productImage, let url = URL(string: urlString) {
                            AsyncImage(url: url)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Text(product.productName ?? "")
                            .font(.caption)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text(product.actualPrice ?? "")
                                .font(.caption2)
                            .foregroundColor(.gray)
                        }
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
    var banners: [Content]
    
    var body: some View {
        TabView {
            ForEach(banners, id: \.title) { banner in
                if let urlString = banner.imageURL, let url = URL(string: urlString) {
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
    var categories: [Content]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id: \.title) { category in
                    VStack {
                        if let urlString = category.imageURL, let url = URL(string: urlString) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
