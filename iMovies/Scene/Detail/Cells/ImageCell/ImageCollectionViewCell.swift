//
//  ImageCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageFilm: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    func configure(withFilmVM viewModel: FilmViewModel?) {
        guard let viewModel = viewModel else { return }
        
        guard let genres = viewModel.film.genres else { return }
        let genresString = genres.map { String($0.name)}
        let joined = genresString.joined(separator: " - ")
        genresLabel.text = joined
        
        voteLabel.text = viewModel.detailVote
        detailLabel.text = viewModel.detail
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.poster)")
        imageFilm.kf.setImage(with: url)
        let backgroundUrl = URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.background)")
        background.kf.setImage(with: backgroundUrl)
        
        background.frame = self.bounds
        background.contentMode = .scaleToFill
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = background.bounds
        background.addSubview(blurredEffectView)
        
    }
}
