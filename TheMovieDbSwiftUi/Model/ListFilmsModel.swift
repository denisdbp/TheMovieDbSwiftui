//
//  ListFilmsModel.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 21/12/22.
//

import Foundation

struct ListFilmsModel:Decodable, Hashable {
    let results:[ResultListFilmsModel]
}

struct ResultListFilmsModel:Decodable, Identifiable, Hashable {
    let id:Int
    let title:String
    let description:String
    let poster:String
    
    enum CodingKeys:String, CodingKey {
        case id
        case title = "original_title"
        case description = "overview"
        case poster = "poster_path"
    }
}
