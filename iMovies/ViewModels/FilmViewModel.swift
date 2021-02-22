//
//  FilmViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

class FilmViewModel {
    let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var poster: String {
        return film.poster
    }
}
