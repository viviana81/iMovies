//
//  FilmListTableViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 23/02/21.
//

import UIKit

class FilmListTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    func configure(withFilm film: FilmViewModel) {
        
    }
}
