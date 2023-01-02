//
//  ListFilmsViewModel.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 21/12/22.
//

import Foundation

class ListFilmsViewModel:ObservableObject {
    
    @Published public var resultListFilmsModel:[ResultListFilmsModel] = []
    @Published public var isLoading:Bool = false
    @Published public var isErrorLoading:Bool = false
    
    private let network:Network = Network()
    public var imageUrl:String = "https://image.tmdb.org/t/p/w500/"
    
    public func getNetwork(_ endPoint:Endpoint){
        self.isLoading = true
        self.network.getEndpoint(endPoint: endPoint, idFilm: "") { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let listFilms):
                DispatchQueue.main.async {
                    guard let listFilms = listFilms as? [ListFilmsModel] else {return}
                    self.resultListFilmsModel = listFilms[0].results
                    self.isLoading = false
                }
            case .failure(_):
                self.isLoading = false
                self.isErrorLoading = true
            }
        }
    }
}
