//
//  DetailViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 24/02/21.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Vars
    private let detailVM: DetailViewModel
    
    init(detailVM: DetailViewModel) {
        self.detailVM = detailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var detailCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.register(ImageCollectionViewCell.self)
        collection.register(ReviewsCollectionViewCell.self)
        collection.register(OverviewCollectionViewCell.self)
        collection.register(KeywordsCollectionViewCell.self)
        collection.register(PeopleCollectionViewCell.self)
        collection.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.kind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collection.dataSource = self
        // collection.delegate = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailCollection.pin(to: view)
        detailVM.getFilmDetail()
        detailVM.reloadData = {
            self.detailCollection.reloadData()
        }
    }
    
    // MARK: - Actions
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let sectionLayoutKind = SectionLayout.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .image:
                return self.imageLayout
            case .reviews:
                return self.reviewsLayout
            case .overview, .keywords:
                return self.overviewsLayout
            case .crew, .cast:
                return self.peopleItemLayout
                
            }
        }
        
        return layout
    }
    
    var imageLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 0,
            trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderView.kind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    // questa è riusata
    var reviewsLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(50))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 0,
            trailing: 5)
        
        group.interItemSpacing = .fixed(CGFloat(10))
    
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    var overviewsLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 1, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(70))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 5,
            bottom: 0,
            trailing: 5)
        // group.interItemSpacing = .fixed(CGFloat(0.0))
    
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(5))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderView.kind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    // questa è riusata
    var peopleItemLayout: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 15,
            bottom: 5,
            trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderView.kind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
}
extension DetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionLayout.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        let section = SectionLayout.allCases[section]
        
        switch section {
        case .image, .reviews, .overview, .keywords:
            return 1
        case .cast:
            return detailVM.cast.count
        case .crew:
            return detailVM.crew.count
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = SectionLayout.allCases[indexPath.section]
        switch section {
        case .image:
            let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFilmVM: detailVM.filmVM)
            return cell
        case .reviews:
            let cell: ReviewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withReviews: detailVM.reviews)
            return cell
        case .overview:
            let cell: OverviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFilmVM: detailVM.filmVM)
            return cell
        case .keywords:
            let cell: KeywordsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withViewModel: detailVM)
            return cell
        case .cast:
            let cell: PeopleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let people = detailVM.cast[indexPath.item]
            cell.configure(withPeopleCast: people)
            return cell
        case .crew:
            let cell: PeopleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let people = detailVM.crew[indexPath.item]
            cell.configure(withPeopleCrew: people)
            return cell
     /*   case .similar, .recomanded:
            let cell: CollectionsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(withFilmVM: detailVM.film)
            return cell
        case .otherImages:
            let cell: ImagesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let image = detailVM.images[indexPath.item]
            cell.configure(withImage: image)
            return cell */
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else {
            fatalError("Cannot create header view")
        }

        if indexPath.section == 0 {
            supplementaryView.label.text = detailVM.filmVM?.film.title
        } else {
            supplementaryView.label.text = SectionLayout.allCases[indexPath.section].title
            supplementaryView.label.font = .boldSystemFont(ofSize: 16)
            
        }
        
        return supplementaryView
    }
}
