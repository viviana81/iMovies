//
//  HomeViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit
import PromiseKit

class HomeViewModel {
    
    let services: Services
    
    init() {
        self.services = ApiServices()
    }
    var nowPlaying: [Film] = []
    var upcoming: [Film] = []
    var popular: [Film] = []
    var top: [Film] = []
    
    var reloadCollection: (() -> Void)?
    
    var sections: [Section] {
        return [
            .nowPlaying,
            .popular,
            .topRated,
            .upcoming
        ]
    }
 
    func fetchData() {
        
        let pNow = nowPromise()
        let pPopular = popularPromise()
        let pUncoming = upcomingPromise()
        let pTop = topPromise()
        
        when(fulfilled: pNow, pPopular, pUncoming, pTop)
        .done { now, popular, upcoming, top in
            self.nowPlaying = now
            self.popular = popular
            self.top = top
            self.upcoming = upcoming
            self.reloadCollection?()
        }.catch { error in
            print(error)
        }
    }

    func nowPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getNowPlaying(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    
    
    func upcomingPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getUpcoming(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    
    func topPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getTopRated(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
    
    func popularPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getPopular(completion: { (filmResp, error) in
                if let films = filmResp?.results {
                    seal.fulfill(films)
                } else if let error = error {
                    seal.reject(error)
                }
            })
        }
    }
}
