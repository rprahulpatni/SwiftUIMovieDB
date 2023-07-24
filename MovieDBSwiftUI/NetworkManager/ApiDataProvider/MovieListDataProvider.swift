//
//  MovieListDataProvider.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import Combine

class MovieListDataProvider {
    static let shared = MovieListDataProvider()
    private var cancellables = Set<AnyCancellable>()
    // Subscribers
    var arrMovieListData = PassthroughSubject<MovieListModel, Never>()

    private init() {}
}
extension MovieListDataProvider {
    func getMovieList(_ pageCount: Int) {
        let url = NetworkURL.getMovieList(apiKey: apikey, pageCount: pageCount).url
        let model = NetworkManager<MovieListModel>.NetworkModel(url: url, method: .get)
        NetworkManager.shared.callAPI(with: model)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { movieList in
            self.arrMovieListData.send(movieList)
        }).store(in: &self.cancellables)
    }
}
