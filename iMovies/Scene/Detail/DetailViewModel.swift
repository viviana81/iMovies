//
//  DetailViewModel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import Foundation
import PromiseKit
import UIKit

class DetailViewModel {
    
    let services: Services
    let filmId: Int
    var filmVM: FilmViewModel?
    var reloadData: (() -> Void)?
    var reviews: [Review] = []
    var keywords: [Keyword] = []
    var cast: [PeopleCast] = []
    var crew: [PeopleCrew] = []
    var similar: [Film] = []

    init(filmId: Int) {
        self.filmId = filmId
        self.services = ApiServices()
    }
    
    func getFilmDetail() {
        
       // let filmPromise = detailPromise()
        
        when(fulfilled: detailPromise(), reviewsPromise(), keywordsPromise(), castPromise(), crewPromise())
        .done {film, reviews, keywords, cast, crew in
            self.filmVM = FilmViewModel(film: film)
            self.reviews = reviews
            self.keywords = keywords
            self.cast = cast
            self.crew = crew
            self.reloadData?()
        }.catch { err in
            print(err)
        }
        
    /*    firstly {
            filmPromise
        } .then { film -> Promise<[Review]> in
            self.filmVM = FilmViewModel(film: film)
            self.reloadData?()
            return self.reviewsPromise()
        } .done { reviews in
            self.reviews = reviews
            self.reloadData?()
        } .catch { error in
            print(error)
        } */
        
      /*  services.getFilm(id: filmId) { film, error in
            if let film = film {
                self.filmVM = FilmViewModel(film: film)
                self.reloadData?()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }*/
    }
    
    func detailPromise() -> Promise<Film> {
        
        return Promise<Film> { seal in
            
            services.getFilm(id: filmId) { (film, error) in
                if let film = film {
                    seal.fulfill(film)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func reviewsPromise() -> Promise<[Review]> {
        
        return Promise<[Review]> { seal in
            
            services.getReviews(id: filmId) { (reviewResp, error) in
                if let reviews = reviewResp?.results {
                    seal.fulfill(reviews)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func keywordsPromise() -> Promise<[Keyword]> {
        
        return Promise<[Keyword]> { seal in
            
            services.getKeywords(id: filmId) { (keyResp, error) in
                if let keywords = keyResp?.keywords {
                    seal.fulfill(keywords)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func castPromise() -> Promise<[PeopleCast]> {
        
        return Promise<[PeopleCast]> { seal in
            
            services.getCredits(id: filmId) { (creditsResp, error) in
                if let cast = creditsResp?.cast {
                    seal.fulfill(cast)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func crewPromise() -> Promise<[PeopleCrew]> {
        
        return Promise<[PeopleCrew]> { seal in
            
            services.getCredits(id: filmId) { (creditsResp, error) in
                if let crew = creditsResp?.crew {
                    seal.fulfill(crew)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    // completare per la chiamata
    func similarPromise() -> Promise<[Film]> {
        
        return Promise<[Film]> { seal in
            
            services.getSimilar(id: filmId) { (filmResp, error) in
                if let similar = filmResp?.results {
                    seal.fulfill(similar)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
}
