//
//  ViewController.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 23/12/22.
//

import UIKit
import SnapKit

class MovieListVC: UIViewController {
    
    // MARK: - Properties
    internal lazy var movieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let vm = MovieListVM()
    var page = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureNavigation()
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        fetchMovie()
    }
    
    // MARK: - Selectors
    func fetchMovie() {
        vm.getMovieList(from: .popular, page: page)
    }
    
    func bindViewModel() {
        
        vm.onFetchSucceed = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.movieListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(movieListTableView)
        movieListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func configureNavigation() {
        
        self.title = "MovieAPI"
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
        
        cell.movie = self.vm.movies[indexPath.row]
        cell.configureUI()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastElement = vm.movies.count - 1
            
        if indexPath.row == lastElement {
            self.page += 1
            self.fetchMovie()
            self.bindViewModel()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        MovieDetailVM().getSingleMovie(id: vm.movies[indexPath.row].id)
    }
}
