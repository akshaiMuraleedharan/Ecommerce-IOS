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
    @Published var categories: [Content] = []
    @Published var banners: [Content] = []
    @Published var bannerSingle: Content?
    @Published var products: [Content] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Model].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] models in
                self?.handleContent(models)
            })
            .store(in: &cancellables)
    }
    
    private func handleContent(_ models: [Model]) {
        for model in models {
            switch model.type {
            case "categories":
                self.categories = model.contents ?? []
            case "banner_slider":
                self.banners = model.contents ?? []
            case "banner_single":
                self.bannerSingle = model.contents?.first
            case "products":
                self.products = model.contents ?? []
            default:
                break
            }
        }
        // Implement offline storage saving logic here
    }
}

