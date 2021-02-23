//
//  ApiServices.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Moya

enum MovieApi {
    case getNowPlaying
    case getPopular
    case getTopRated
    case getUpcoming
    case getGenre
}

extension MovieApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .getNowPlaying:
            return "movie/now_playing"
        case .getPopular:
            return "movie/popular"
        case .getTopRated:
            return "movie/top_rated"
        case .getUpcoming:
            return "movie/upcoming"
        case .getGenre:
            return "genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopular, .getNowPlaying, .getTopRated, .getUpcoming, .getGenre:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNowPlaying, .getPopular, .getTopRated, .getUpcoming, .getGenre:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        
        let code = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZjAzZWNhYzgwMDhhODhkZTkyZDI3OTU1NGVhMjJjMCIsInN1YiI6IjYwMzM1NDhmZmFiM2ZhMDAzYzAxMTI3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EyqTwH6EAjUc9Yi9AnXtDtAGbqJRHfDok02lrvCRUG0"
        
        return ["Authorization": code]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
