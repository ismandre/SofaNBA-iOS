//
//  PlayerTeamCell.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 14.05.2022..
//

import UIKit

class PlayerCell: UITableViewCell {
    
    var playerImageView  = UIImageView()
    var playerNameLabel = UILabel()
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
        addSubview(playerImageView)
        addSubview(playerNameLabel)
        addSubview(favoritesImageView)
    }
    
    func configureViews() {
        configurePlayerImageView()
        configurePlayerNameLabel()
        configureFavoritesImageView()
    }
    
    func setConstraints() {
        setPlayerImageConstraints()
        setPlayerNameLabelConstraints()
        setFavoritesImageConstraints()
    }
    
    func configurePlayerImageView() {
        playerImageView.layer.cornerRadius = 10
        playerImageView.clipsToBounds = true
    }
    
    func configurePlayerNameLabel() {
        playerNameLabel.numberOfLines = 0
        playerNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureFavoritesImageView() {
        favoritesImageView.image = UIImage(systemName: "star.fill")
    }
    
    func setPlayerImageConstraints() {
        playerImageView.translatesAutoresizingMaskIntoConstraints                                = false
        playerImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                = true
        playerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive  = true
        playerImageView.heightAnchor.constraint(equalToConstant: 80).isActive                    = true
        playerImageView.widthAnchor.constraint(equalTo: playerImageView.heightAnchor).isActive = true
    }
    
    func setPlayerNameLabelConstraints() {
        playerNameLabel.translatesAutoresizingMaskIntoConstraints                                                  = false
        playerNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                  = true
        playerNameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20).isActive = true
        playerNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive                                      = true
        playerNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                 = true
    }
    
    func setFavoritesImageConstraints() {
        favoritesImageView.translatesAutoresizingMaskIntoConstraints                                 = false
        favoritesImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                 = true
        favoritesImageView.heightAnchor.constraint(equalToConstant: 20).isActive                     = true
        favoritesImageView.widthAnchor.constraint(equalTo: favoritesImageView.heightAnchor).isActive = true
        favoritesImageView.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -20).isActive = true
    }

    func set(player: Player) {
        playerImageView.image = player.image
        playerNameLabel.text = player.name
    }

}
