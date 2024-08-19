//
//  ProductViews.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 19/08/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductsView: View {
    var products: [Product]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(products) { product in
                    VStack(alignment: .leading, spacing: 6) {
                        if let urlString = product.productImage, let url = URL(string: urlString) {
                            WebImage(url: url)
                                .resizable()
                                .frame(width: 96, height: 152)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        if product.discount != "0% Off" {
                            Text("Sale \(product.discount)")
                                .frame(width: 70, height: 18)
                                .font(.caption2)
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color("Colororange"))
                                .clipShape(Capsule())
                        }
                        Text(product.productName)
                            .font(.system(size: 10))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        
                        RatingView(rating: .constant(4))
                        
                        HStack(spacing: 2) {
                            if product.actualPrice != product.offerPrice {
                                Text(product.offerPrice)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            Text(product.actualPrice)
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .strikethrough()
                        }
                        .frame(alignment: .leading)
                    }
                    .padding(.all, 8)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BorderColor"), lineWidth: 1)
                    )
                    .frame(width: 170, height: 315) 
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
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 124)
    }
}

struct CategoriesView: View {
    var categories: [CategoryContent]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 5) {
                ForEach(categories) { category in
                    VStack(spacing: 4) {
                        if let urlString = category.imageURL, let url = URL(string: urlString) {
                            WebImage(url: url)
                                .resizable()
                                .frame(width: 94, height: 64)
                        }
                        Text(category.title)
                            .font(.caption)
                    }
                    .padding(.vertical, 8)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BorderColor"), lineWidth: 1)
                    )
                    .frame(width: 100, height: 150)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HomeView: View {
    @ObservedObject var viewModel = DataViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        if let bannerSlider = viewModel.bannerSlider {
                            BannerSliderView(banners: bannerSlider.contents)
                        }
                        
                        HStack {
                            Text("Most Popular")
                                .font(.system(size: 20, weight: .medium))
                            Spacer()
                            Button("View all") {
                                // View all action
                            }
                            .foregroundColor(.black)
                        }
                        .padding(.all, 5)
                        
                        if let mostPopular = viewModel.mostPopular {
                            ProductsView(products: mostPopular.contents)
                        }
                        
                        if let bannerSingle = viewModel.bannerSingle {
                            if let urlString = bannerSingle.imageURL, let url = URL(string: urlString) {
                                WebImage(url: url)
                                    .resizable()
                                    .frame(width: 336, height: 100)
                                    .clipped()
                                    .padding(.horizontal)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        
                        HStack {
                            Text("Categories")
                                .font(.system(size: 20, weight: .medium))
                            Spacer()
                            Button("View all") {
                                // View all action
                            }
                            .foregroundColor(.black)
                        }
                        .padding(.all, 5)
                        
                        if let categories = viewModel.categories {
                            CategoriesView(categories: categories.contents)
                        }
                        
                        HStack {
                            Text("Featured Products")
                                .font(.system(size: 20, weight: .medium))
                            Spacer()
                            Button("View all") {
                                // View all action
                            }
                            .foregroundColor(.black)
                        }
                        .padding(.all, 5)
                        
                        if let bestSellers = viewModel.bestSellers {
                            ProductsView(products: bestSellers.contents)
                        }
                    }
                }
            }
        }
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

#Preview {
    DashboardView()
}

