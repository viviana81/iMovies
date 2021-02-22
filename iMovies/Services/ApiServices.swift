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
    
    // queste sono tuttte uguali si può ottimizzare?
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
        
    }
    
    func getLatest(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        
    }
    
    func getTopRated(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        
    }
    
    func getUpcoming(completion: @escaping (FilmResponse<Film>?, Error?) -> Void) {
        
    }
}
