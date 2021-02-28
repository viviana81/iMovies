//
//  KeywordsCollectionViewCell.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 26/02/21.
//

import UIKit

class KeywordsCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var keywordButton: UIButton!
    
    func configure(withKeyword keyword: Keyword) {
        keywordButton.setTitle("\(keyword.name)", for: .normal)
    }
}
