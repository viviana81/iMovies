//
//  FilmCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 22/02/21.
//

import UIKit
import Kingfisher

class FilmCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var filmImage: UIImageView!
    
    // il configure va fatto con il filmViewModel
    func configure(withFilm film: Film) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.poster)")
        filmImage.kf.setImage(with: url)
    }
}
