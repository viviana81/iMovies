//
//  HomeViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

class HomeViewModel {
    
    var nowPlaying: [Film] = []
    var upcoming: [Film] = []
    var latest: [Film] = []
    var popular: [Film] = []
    var top: [Film] = []
    
    var sections: [Section] {
        return [
            .latest,
            .nowPlaying,
            .popular,
            .topRated,
            .upcoming
        ]
        
    }
    func fetchData() {
        // getfilm
    }
}
