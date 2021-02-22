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
}

extension MovieApi: TargetType {
    
    var baseURL: URL {
       return URL(string: "https://api.themoviedb.org/3/movie/")!
    }
    
    var path: String {
        switch self {
        case .getNowPlaying:
            return "now_playing"
        case .getPopular:
            return "popular"
        case .getTopRated:
            return "top_rated"
        case .getUpcoming:
            return "upcoming"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopular, .getNowPlaying, .getTopRated, .getUpcoming:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNowPlaying, .getPopular, .getTopRated, .getUpcoming:
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
