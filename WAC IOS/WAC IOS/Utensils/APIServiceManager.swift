//
//  APIServiceManager.swift
//  WAC IOS
//
//  Created by Subhosting's MacBook Pro on 17/08/24.
//

//import Foundation
//
//// MARK: - APIServiceManager
//
//class APIServiceManager {
//
//    // Singleton instance
//    static let shared = APIServiceManager()
//    
//    private init() {}
//
//    // URL for the API
//    private let baseURL = "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo"
//
//    // Fetch data from the API
//    func fetchData<T: Codable>(for type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
//        guard let url = URL(string: baseURL) else {
//            completion(.failure(APIError.invalidURL))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(APIError.noData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode([T].self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//    
//    // Enum for API errors
//    enum APIError: Error {
//        case invalidURL
//        case noData
//        case decodingError
//    }
//}
