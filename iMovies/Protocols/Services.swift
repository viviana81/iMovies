//
//  Services.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

protocol Services {
    
    func getNowPlaying(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getPopular(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getTopRated(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getUpcoming(completion: @escaping(FilmResponse<Film>?, Error?) -> Void)
    func getGenre(completion: @escaping(GenreResponse?, Error?) -> Void)
}
