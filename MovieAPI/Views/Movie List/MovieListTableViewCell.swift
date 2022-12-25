//
//  MovieListTableViewCell.swift
//  MovieAPI
//
//  Created by Stephen Giovanni Saputra on 25/12/22.
//

import UIKit
import SnapKit

class MovieListTableViewCell: UITableViewCell {

    static let identifier = "MovieListTableViewCell"
    
    internal lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    var movie: Movie? = nil
    
    func configureUI() {
        
        contentView.backgroundColor = .clear
        
        movieTitleLabel.text = movie?.title
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
}
