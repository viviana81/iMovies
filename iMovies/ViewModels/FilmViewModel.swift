//
//  FilmViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

class FilmViewModel {
    var film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var poster: String {
        return film.poster
    }
    
    var title: String {
        return film.title
    }
    
    var date: String {
       
        return film.date
    }
    
    var vote: String {
        return String(film.vote)
    }
    
    var description: String {
        return film.overview
    }
    var detail: String {
        guard let runtime = film.runtime,
              let status = film.status else { return " " }
        
        return "\(film.date) - \(runtime) minutes - \(status)"
    }
    
    var background: String {
        return film.backdrop
    }
    
    var detailVote: String {
        return "Vote: \(film.vote)"
    }
}
