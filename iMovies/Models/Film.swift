//
//  Film.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

struct Film: Codable {
    let adult: Bool
    let backdrop: String
    let id: String
    let title: String
    let language: String
    let overview: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case title = "original_title"
        case language = "original_language"
        case poster = "poster_path"
        
        case id, overview, adult
    }
}

struct FilmResponse<T: Decodable>: Decodable {
   // let dates:
    let page: Int
    let results: [T]

}
