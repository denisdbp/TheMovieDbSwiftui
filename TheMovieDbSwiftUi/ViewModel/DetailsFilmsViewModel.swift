//
//  DetailsFilmsViewModel.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 27/12/22.
//

import Foundation

class DetailsFilmsViewModel:ObservableObject {
    
    @Published public var detailsFilmsModel:[DetailsFilmsModel] = []
    @Published public var returnListFilm:Bool = false
    @Published public var isErrorLoading:Bool = false
    
    private var network:Network = Network()
    public var imageUrl:String = "https://image.tmdb.org/t/p/w500/"
    
    public func getNetwork(_ endPoint:Endpoint, idFilm:String){
        self.network.getEndpoint(endPoint: endPoint, idFilm: idFilm) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let detailsFilm):
                DispatchQueue.main.async {
                    guard let detailsFilmsModel = detailsFilm as? [DetailsFilmsModel] else {return}
                    self.detailsFilmsModel = detailsFilmsModel
                }
            case .failure(_):
                self.isErrorLoading = true
            }
        }
    }
}
