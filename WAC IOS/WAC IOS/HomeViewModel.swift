//
//  HomeViewModel.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

import Foundation
import Combine
import CoreData

class HomeViewModel: ObservableObject {
    @Published var categories: [Content.ContentDetail] = []
    @Published var banners: [Content.ContentDetail] = []
    @Published var bannerSingle: Content.ContentDetail?
    @Published var products: [Content.ContentDetail] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Content].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] contents in
                self?.handleContent(contents)
            })
            .store(in: &cancellables)
    }
    
    private func handleContent(_ contents: [Content]) {
        for content in contents {
            switch content.type {
            case .categories:
                self.categories = content.contents.filter { $0.title != nil && $0.imageUrl != nil }
            case .bannerSlider:
                self.banners = content.contents.filter { $0.title != nil && $0.imageUrl != nil }
            case .bannerSingle:
                if let banner = content.contents.first {
                    self.bannerSingle = banner
                }
            case .products:
                self.products = content.contents.filter { $0.productName != nil && $0.productImage != nil }
            default:
                break
            }
        }
        // Implement offline storage saving logic here
    }
}
