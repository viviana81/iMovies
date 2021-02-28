//
//  CollectionsCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 25/02/21.
//

import UIKit

class CollectionsCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(withFilmVM film: FilmViewModel) {
        titleLabel.text = film.film.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.film.poster)")
        filmImage.kf.setImage(with: url)
    }
}
