//
//  ApiResponse.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

import Foundation

enum ContentType: String, Decodable {
    case bannerSlider = "banner_slider"
    case products
    case bannerSingle = "banner_single"
    case categories = "catagories" // Corrected the key name to match the JSON
    case type3 = "type 3"
    case type4 = "type 4"
    case type5 = "type 5"
    case type6 = "type 6"
}

struct Content: Identifiable, Decodable {
    let id: String
    let type: ContentType
    let title: String?
    let contents: [ContentDetail]

    struct ContentDetail: Decodable, Identifiable {
        let id = UUID()
        let title: String?
        let imageUrl: String? 
        let sku: String?
        let productName: String?
        let productImage: String?
        let productRating: Int?
        let actualPrice: String?
        let offerPrice: String?
        let discount: String?
    }
}
