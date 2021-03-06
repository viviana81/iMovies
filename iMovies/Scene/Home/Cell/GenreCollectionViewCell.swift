//
//  GenreCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(withGenre genre: Genre) {
        nameLabel.text = genre.name
    }
}
