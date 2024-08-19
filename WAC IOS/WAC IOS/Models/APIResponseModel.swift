//
//  APIResponseModel.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 19/08/24.
//

import Foundation

enum APIData: Decodable {
    case bannerSlider(BannerSlider)
    case bestSellers(BestSellers)
    case bannerSingle(BannerSingle)
    case categories(Categories)
    case mostPopular(MostPopular)
    case emptyType(EmptyType)

    private enum CodingKeys: String, CodingKey {
        case title
    }

    private enum DataTitle: String {
        case topBanner = "Top banner"
        case bestSellers = "Best Sellers"
        case adBanner = "ad banner"
        case topCategories = "Top categories"
        case mostPopular = "Most Popular"
        case title3 = "title 3"
        case title4 = "title 4"
        case title5 = "title 5"
        case title6 = "title 6"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        
        switch title {
        case DataTitle.topBanner.rawValue:
            let value = try BannerSlider(from: decoder)
            self = .bannerSlider(value)
        case DataTitle.bestSellers.rawValue:
            let value = try BestSellers(from: decoder)
            self = .bestSellers(value)
        case DataTitle.adBanner.rawValue:
            let value = try BannerSingle(from: decoder)
            self = .bannerSingle(value)
        case DataTitle.topCategories.rawValue:
            let value = try Categories(from: decoder)
            self = .categories(value)
        case DataTitle.mostPopular.rawValue:
            let value = try MostPopular(from: decoder)
            self = .mostPopular(value)
        case DataTitle.title3.rawValue, DataTitle.title4.rawValue, DataTitle.title5.rawValue, DataTitle.title6.rawValue:
            let value = try EmptyType(from: decoder)
            self = .emptyType(value)
        default:
            throw DecodingError.dataCorruptedError(forKey: .title, in: container, debugDescription: "Invalid title: \(title)")
        }
    }
}
