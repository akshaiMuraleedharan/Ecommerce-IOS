//
//  HomeViewModel.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

import SwiftUI
import Combine

class DataViewModel: ObservableObject {
    @Published var bannerSlider: BannerSlider?
    @Published var bestSellers: BestSellers?
    @Published var bannerSingle: BannerSingle?
    @Published var categories: Categories?
    @Published var mostPopular: MostPopular?
    @Published var isLoading = true
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        guard let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [APIData].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Failed to fetch data: \(error)")
                }
            }, receiveValue: { [weak self] apiDataArray in
                self?.parseData(apiDataArray)
            })
            .store(in: &cancellables)
    }
    
    private func parseData(_ apiDataArray: [APIData]) {
        for data in apiDataArray {
            switch data {
            case .bannerSlider(let value):
                self.bannerSlider = value
            case .bestSellers(let value):
                self.bestSellers = value
            case .bannerSingle(let value):
                self.bannerSingle = value
            case .categories(let value):
                self.categories = value
            case .mostPopular(let value):
                self.mostPopular = value
            case .emptyType:
                print("EmptyType received")
            }
        }
    }
}
