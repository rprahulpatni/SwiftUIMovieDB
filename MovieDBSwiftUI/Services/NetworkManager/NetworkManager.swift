//
//  NetworkManager.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
}

// MARK: - NetworkManager
///NetworkManager class is a generic class that can handle API calls for any Decodable model T. It creates a NetworkModel representing the API request details, including URL, HTTP method, and optional request body. The callAPI method is used to make the API call using URLSession's dataTaskPublisher and return a Combine publisher with the API response or an error.

/// Generic network manager class for making API calls and handling responses.
class NetworkManager{
    // MARK: - NetworkModel
    /// Model representing API request details.
    struct NetworkModel{
        let url: URL?
        let method: HTTPMethod
        let body: JSON? = nil
    }
 
    ///   Make an API call and return a Combine publisher with the API response.
    /// - Parameter model: The `NetworkModel` containing API request details.
    /// - Returns: A Combine publisher with the API response or an error.
    func callAPI<T: Decodable>(with model: NetworkModel) -> AnyPublisher<T, Error> {
        //URL validation before prrocedding
        guard let url = model.url else {
            return Fail(error: NSError(domain: "Missing API URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        //Request header (customizable as per need)
        let requestHeaders: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
        //Creating a URLRequest with URL and HTTPMethod
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = model.method.rawValue
        urlRequest.allHTTPHeaderFields = requestHeaders
        // If a request body is provided, encode it as JSON and attach it to the request.
        if let body = model.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        // Perform the API call using URLSession dataTaskPublisher.
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ data, response in
                //Checking response statuc code
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)// Switch the execution context to the main thread.
            .eraseToAnyPublisher()// Type-erase to AnyPublisher<String, Never>
    }
}
