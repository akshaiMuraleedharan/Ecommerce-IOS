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
    @Published var additionalData: [Model] = [] // For unknown types

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Model].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] models in
                self?.handleContent(models)
                self?.saveToOfflineStorage(models)
            })
            .store(in: &cancellables)
    }
    
    private func handleContent(_ models: [Model]) {
        self.additionalData = models
        
        for model in models {
            switch model.type {
            case "catagories":
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
    }
    
    private func saveToOfflineStorage(_ models: [Model]) {
        // Implement offline storage saving logic using SQLite or CoreData
    }
}
