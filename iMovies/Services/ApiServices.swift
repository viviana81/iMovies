//
//  MovieApi.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Moya

struct ApiServices: Services {
    
    let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: false, cURL: true)])
    
    let decoder: JSONDecoder
    
    init() {
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getNowPlaying(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getNowPlaying) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getPopular(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getPopular) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
        
    func getTopRated(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getTopRated) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getUpcoming(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        provider.request(.getUpcoming) { result in
            switch result {
            case .success(let response):
                let filmResp = try? decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func getGenre(completion: @escaping (GenreResponse?, Error?) -> Void) {
        provider.request(.getGenre) { result in
            switch result {
            case .success(let response):
                let genreResp = try? decoder.decode(GenreResponse.self, from: response.data)
                completion(genreResp, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getFilm(id: Int, completion: @escaping (Film?, Error?) -> Void) {
        provider.request(.getFilm(id: id)) { result  in
            switch result {
            case .success(let response):
                let film = try? decoder.decode(Film.self, from: response.data)
                completion(film, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getReviews(id: Int, completion: @escaping (ReviewResponse?, Error?) -> Void) {
        provider.request(.getReviews(id: id)) { result in
            switch result {
            case .success(let response):
                let reviewResp = try? decoder.decode(ReviewResponse.self, from: response.data)
                completion(reviewResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getKeywords(id: Int, completion: @escaping (KewordsResponse?, Error?) -> Void) {
        provider.request(.getKeywords(id: id)) { result in
            switch result {
            case .success(let response):
                let keyResp = try? decoder.decode(KewordsResponse.self, from: response.data)
                completion(keyResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
