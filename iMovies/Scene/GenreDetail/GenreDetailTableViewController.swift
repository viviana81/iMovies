//
//  GenreDetailTableViewController.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 05/03/21.
//

import UIKit

class GenreDetailTableViewController: UITableViewController {
        
    // MARK: - Vars
    let genreDetailVM: GenreDetailViewModel
    
    init(genreDetailVM: GenreDetailViewModel) {
        self.genreDetailVM = genreDetailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.register(FilmListTableViewCell.self)
        genreDetailVM.getMoviesByGenre()
        genreDetailVM.reloadData = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: actions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreDetailVM.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilmListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let film = genreDetailVM.movies[indexPath.row]
        cell.configure(withFilm: film)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // TODO: mettere nome del genre
        return "\(genreDetailVM.genreId)"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
