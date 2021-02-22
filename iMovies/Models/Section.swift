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
    case latest
    case topRated
    case upcoming
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now playing"
        case .popular:
            return "Popular"
        case .latest:
            return "Latest"
        case .topRated:
            return "Top"
        case .upcoming:
            return "Upcoming"
    
        }
    }
}
