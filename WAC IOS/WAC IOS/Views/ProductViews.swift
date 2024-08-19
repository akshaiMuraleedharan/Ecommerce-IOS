//
//  ProductViews.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 19/08/24.
//

import SwiftUI
import UIKit
import SDWebImage
import SDWebImageSwiftUI

struct ProductsView: View {
    var products: [Product]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(products) { product in
                    VStack {
                        if let urlString = product.productImage, let url = URL(string: urlString) {
                            WebImage(url: url)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Text(product.productName)
                            .font(.caption)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text(product.actualPrice)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        if product.actualPrice != product.offerPrice {
                            Text(product.offerPrice)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        if product.discount != "0% Off" {
                            Text(product.discount)
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
    var banners: [BannerContent]
    
    var body: some View {
        TabView {
            ForEach(banners) { banner in
                WebImage(url: URL(string: banner.imageURL))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
    }
}

struct CategoriesView: View {
    var categories: [CategoryContent]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories) { category in
                    VStack {
                        if let urlString = category.imageURL, let url = URL(string: urlString) {
                            WebImage(url: url)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                        Text(category.title)
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = DataViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                if let bannerSlider = viewModel.bannerSlider {
                    BannerSliderView(banners: bannerSlider.contents)
                }
                
                HStack {
                    Text("Best Sellers")
                    Spacer()
                    Button("View All") {
                        // View all action
                    }
                }
                
                if let bestSellers = viewModel.bestSellers {
                    ProductsView(products: bestSellers.contents)
                }
                
                if let bannerSingle = viewModel.bannerSingle {
                    if let urlString = bannerSingle.imageURL, let url = URL(string: urlString) {
                        WebImage(url: url)
                            .resizable()
                            .frame(height: 150)
                            .clipped()
                            .padding(.horizontal)
                    }
                }
                
                HStack {
                    Text("Categories")
                    Spacer()
                    Button("View All") {
                        // View all action
                    }
                }
                
                if let categories = viewModel.categories {
                    CategoriesView(categories: categories.contents)
                }
                
                HStack {
                    Text("Most Popular")
                    Spacer()
                    Button("View All") {
                        // View all action
                    }
                }
                
                if let mostPopular = viewModel.mostPopular {
                    ProductsView(products: mostPopular.contents)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchData()
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


