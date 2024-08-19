//
//  ApiResponse.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

import Foundation

// MARK: - BannerSlider
struct BannerSlider: Codable {
    let type: String
    let title: String
    let contents: [BannerContent]
    let id: String
}

struct BannerContent: Codable, Identifiable {
    var id = UUID()
    
    let title: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
    }
}

// MARK: - BestSellers
struct BestSellers: Codable {
    let type: String
    let title: String
    let contents: [Product]
    let id: String
}

// MARK: - BannerSingle
struct BannerSingle: Codable {
    let type: String
    let title: String
    let imageURL: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case type
        case title
        case imageURL = "image_url"
        case id
    }
}

// MARK: - Categories
struct Categories: Codable {
    let type: String
    let title: String
    let contents: [CategoryContent]
    let id: String
}

struct CategoryContent: Codable, Identifiable {
    var id = UUID()
    
    let title: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
    }
}

// MARK: - MostPopular
struct MostPopular: Codable {
    let type: String
    let title: String
    let contents: [Product]
    let id: String
}

// MARK: - Product
struct Product: Codable, Identifiable {
    var id = UUID()
    let sku: String
    let productName: String
    let productImage: String?
    let productRating: Int
    let actualPrice: String
    let offerPrice: String
    let discount: String

    enum CodingKeys: String, CodingKey {
        case sku
        case productName = "product_name"
        case productImage = "product_image"
        case productRating = "product_rating"
        case actualPrice = "actual_price"
        case offerPrice = "offer_price"
        case discount
    }
}

// MARK: - EmptyType
struct EmptyType: Codable {
    let type: String
    let contents: [String] // or use any appropriate type if contents need to be more specific
    let title: String
    let id: String
}
