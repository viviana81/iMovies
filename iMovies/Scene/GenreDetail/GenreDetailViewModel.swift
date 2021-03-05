//
//  GenreDetailViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 05/03/21.
//

import Foundation

class GenreDetailViewModel {
    
    let services: Services
    let genreId: Int
    var genreVM: GenreViewModel?
    var movies: [Film] = []
    var reloadData: (() -> Void)?
    
    init(genreId: Int) {
        self.genreId = genreId
        self.services = ApiServices()
    }
    
    func getMoviesByGenre() {
        
        services.getGenreMovies(id: genreId) { moviesResp, error in
            if let moviesResp = moviesResp {
                self.movies = moviesResp.results
                self.reloadData?()
            } else if let error = error {
                print(error)
            }
        }
    }
}
