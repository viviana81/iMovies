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
    
    func getNowPlaying() {
        
    }
    
    func getPopular() {
        
    }
    
    func getLatest() {
        
    }
    
    func getTopRated() {
        
    }
    
    func getUpcoming() {
        
    }
}
