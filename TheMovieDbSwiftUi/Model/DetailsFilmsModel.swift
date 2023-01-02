//
//  DetailsFilmsModel.swift
//  TheMovieDbSwiftUi
//
//  Created by Denis Bortoletto Pereira on 27/12/22.
//

import Foundation

struct DetailsFilmsModel:Decodable {
    let title:String
    let description:String
    let poster:String
    
    enum CodingKeys:String, CodingKey {
        case title = "original_title"
        case description = "overview"
        case poster = "poster_path"
    }
}
