//
//  TeamCell.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 24.05.2022..
//

import UIKit

class TeamCell: UITableViewCell {

    var teamLogoImageView  = UIImageView()
    var teamNameLabel = UILabel()
    var favoritesImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
        addSubview(favoritesImageView)
    }
    
    func configureViews() {
        configureTeamLogoImageView()
        configureTeamNameLabel()
        configureFavoritesImageView()
    }
    
    func setConstraints() {
        setTeamLogoImageConstraints()
        setTeamNameLabelConstraints()
        setFavoritesImageConstraints()
    }
    
    func configureTeamLogoImageView() {
        teamLogoImageView.layer.cornerRadius = 10
        teamLogoImageView.clipsToBounds = true
    }
    
    func configureTeamNameLabel() {
        teamNameLabel.numberOfLines = 0
        teamNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureFavoritesImageView() {
        favoritesImageView.image = UIImage(systemName: "star.fill")
    }
    
    func setTeamLogoImageConstraints() {
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints                                = false
        teamLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                = true
        teamLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive  = true
        teamLogoImageView.heightAnchor.constraint(equalToConstant: 80).isActive                    = true
        teamLogoImageView.widthAnchor.constraint(equalTo: teamLogoImageView.heightAnchor).isActive = true
    }
    
    func setTeamNameLabelConstraints() {
        teamNameLabel.translatesAutoresizingMaskIntoConstraints                                                  = false
        teamNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                  = true
        teamNameLabel.leadingAnchor.constraint(equalTo: teamLogoImageView.trailingAnchor, constant: 20).isActive = true
        teamNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive                                      = true
        teamNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                 = true
    }
    
    func setFavoritesImageConstraints() {
        favoritesImageView.translatesAutoresizingMaskIntoConstraints                                 = false
        favoritesImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                 = true
        favoritesImageView.heightAnchor.constraint(equalToConstant: 20).isActive                     = true
        favoritesImageView.widthAnchor.constraint(equalTo: favoritesImageView.heightAnchor).isActive = true
        favoritesImageView.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -20).isActive = true
    }

    func set(team: Team) {
        teamLogoImageView.image = team.image
        teamNameLabel.text = team.name
    }
}
