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
                let filmResp = try! decoder.decode(FilmResponse<Film>.self, from: response.data)
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
                let filmResp = try! decoder.decode(FilmResponse<Film>.self, from: response.data)
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
                let filmResp = try! decoder.decode(FilmResponse<Film>.self, from: response.data)
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
                let filmResp = try! decoder.decode(FilmResponse<Film>.self, from: response.data)
                completion(filmResp, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
