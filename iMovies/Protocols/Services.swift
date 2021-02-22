//
//  Services.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import Foundation

protocol Services {
    
    func getNowPlaying()
    func getPopular()
    func getLatest()
    func getTopRated()
    func getUpcoming()
}
