//
//  APIServiceManager.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

//import Foundation
//import Combine
//
//class APIServiceManager {
//    static let shared = APIServiceManager()
//    private let url = URL(string: "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo")!
//
//    func fetchData() -> AnyPublisher<[ApiResponse], Error> {
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: [ApiResponse].self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//}
