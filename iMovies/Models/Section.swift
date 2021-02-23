//
//  FilmType.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

enum Section: CaseIterable {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case genres
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top"
        case .upcoming:
            return "Upcoming"
        case .genres:
            return "Genres"
        }
    }
}
