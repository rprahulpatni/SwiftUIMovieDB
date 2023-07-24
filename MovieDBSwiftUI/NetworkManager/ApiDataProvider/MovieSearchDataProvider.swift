//
//  MovieSearchDataProvider.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 22/07/23.
//

import Foundation
import Combine

class MovieSearchDataProvider {
    static let shared = MovieSearchDataProvider()
    private var cancellables = Set<AnyCancellable>()
    // Subscribers
    var arrMovieSearchData = PassthroughSubject<[MovieSearchData], Never>()
    private init() {}
}

extension MovieSearchDataProvider {
    func getMovieList(_ searchText: String) {
        guard let encodedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let url = NetworkURL.getMovieSearch(apiKey: apikey, query: encodedString).url
        let model = NetworkManager<MovieSearchModel>.NetworkModel(url: url, method: .get)
        NetworkManager.shared.callAPI(with: model)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            guard let items = movieList.results else { return }
            self.arrMovieSearchData.send(items)
        }).store(in: &self.cancellables)
    }
}
