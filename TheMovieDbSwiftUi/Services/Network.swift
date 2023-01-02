//
//  Network.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 21/12/22.
//

import Foundation

enum Endpoint:String {
    case listFilms = "https://api.themoviedb.org/3/movie/popular?"
    case detailsFilm = "https://api.themoviedb.org/3/movie/"
}

class Network {
    
    private let keyApi = "api_key=0f9a3cef12bf5788122f13b1532b9b9e"
    private let language = "&language=pt-BR"
    
    public func getEndpoint(endPoint:Endpoint, idFilm:String, completion:@escaping(Result<Any, Error>)->Void){
        switch endPoint {
        case .listFilms:
            self.request("\(endPoint.rawValue)\(self.keyApi)\(self.language)", ListFilmsModel.self) { result in
                switch result {
                case .success(let listFilms):
                    completion(.success(listFilms))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
        case .detailsFilm:
            self.request("\(endPoint.rawValue)\(idFilm)?\(self.keyApi)\(self.language)", DetailsFilmsModel.self) { result in
                switch result {
                case .success(let detailsFilm):
                    completion(.success(detailsFilm))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
        }
    }
    
    private func request<T:Decodable>(_ path:String, _ model:T.Type, completion:@escaping(Result<Any, Error>)->Void) {
        guard let url = URL(string: path) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                let json = try? JSONDecoder().decode(model.self, from: data)
                completion(.success([json]))
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
                guard let error = error else {return}
                switch response.statusCode {
                case 400...500:
                    completion(.failure(error))
                    break
                default:
                    break
                }
            }
        }
        task.resume()
    }
}
