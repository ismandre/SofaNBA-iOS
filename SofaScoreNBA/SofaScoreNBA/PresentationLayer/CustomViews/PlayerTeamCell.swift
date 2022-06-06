//
//  PlayerTeamCell.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 02.06.2022..
//

import UIKit

class PlayerTeamCell: UITableViewCell {
    
    let apiService = ApiService()
    
    var entityImageView = UIImageView()
    var entityNameLabel = UILabel()
    var playerOriginLabel = UILabel()
    var favoritesButton = UIButton()
    
    private var imageURL = ""
    
    private var urlString = ""

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
        addSubview(entityImageView)
        addSubview(entityNameLabel)
        addSubview(playerOriginLabel)
    }
    
    func configureViews() {
        configureEntityImageView()
        configureEntityNameLabel()
        configurePlayerOriginLabel()
        configureFavoritesButton()
    }
    
    func setConstraints() {
        setEntityImageConstraints()
        setEntityNameLabelConstraints()
        setPlayerOriginLabelConstraints()
    }
    
    func configureEntityImageView() {
        entityImageView.layer.cornerRadius = 10
        entityImageView.clipsToBounds = true
    }
    
    func configureEntityNameLabel() {
        entityNameLabel.numberOfLines = 0
        entityNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configurePlayerOriginLabel() {
        playerOriginLabel.textColor = .systemGray
    }
    
    func configureFavoritesButton() {
        let image = UIImage(systemName: "star")?.withTintColor(.systemRed)
        self.favoritesButton.setImage(image, for: .normal)
        self.favoritesButton.tintColor = .systemRed
        self.favoritesButton.sizeToFit()
        accessoryView = self.favoritesButton
    }
    
    func setEntityImageConstraints() {
        entityImageView.translatesAutoresizingMaskIntoConstraints                               = false
        entityImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive               = true
        entityImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        entityImageView.heightAnchor.constraint(equalToConstant: 80).isActive                   = true
        entityImageView.widthAnchor.constraint(equalTo: entityImageView.heightAnchor).isActive  = true
    }
    
    func setEntityNameLabelConstraints() {
        entityNameLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        entityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                = true
        entityNameLabel.leadingAnchor.constraint(equalTo: entityImageView.trailingAnchor, constant: 20).isActive = true
        entityNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive                                    = true
        entityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive               = true
    }
    
    func setPlayerOriginLabelConstraints() {
        playerOriginLabel.translatesAutoresizingMaskIntoConstraints = false
        playerOriginLabel.topAnchor.constraint(equalTo: entityNameLabel.bottomAnchor, constant: -30).isActive = true
        playerOriginLabel.leadingAnchor.constraint(equalTo: entityNameLabel.leadingAnchor).isActive = true
    }
    
    // Setup player or teams values
    func setCellWithValuesOf(isPlayer: Bool, name: String?, origin: String, id: Int, row: Int) {
        updateUI(isPlayer: isPlayer, name: name, origin: origin, id: id, row: row)
    }

    private func updateUI(isPlayer: Bool, name: String?, origin: String?, id: Int, row: Int) {
        self.entityNameLabel.text = name
        self.entityImageView.image = nil
        self.entityImageView.backgroundColor = .clear
        if isPlayer {
            self.playerOriginLabel.text = origin
            
            apiService.getImagesForPlayerId(playerId: id, completion: { (result) in
                switch result {
                case .success(let listOf):
                    guard let imageURL = URL(string: listOf.data[0].imageUrl) else { return }
                    DispatchQueue.main.async {[weak self] in
                        if let imageData = try? Data(contentsOf: imageURL) {
                            if let loadedImage = UIImage(data: imageData) {
                                self?.entityImageView.image = loadedImage
                            }
                        }
                    }
                    break
                case .failure(let error):
                    print("Error processing json data: \(error)")
                    DispatchQueue.main.async {
                        switch row % 3 {
                        case 0:
                            self.entityImageView.image = UIImage(named: "dribbler")
                        case 1:
                            self.entityImageView.image = UIImage(named: "jumper")
                        default:
                            self.entityImageView.image = UIImage(named: "shooter")
                        }
                    }
                }
            })
        } else {
            self.playerOriginLabel.text = ""
            self.entityImageView.image = UIImage(named: name!)
            self.entityImageView.backgroundColor = ColorPalette().teamsPrimary[name!]
        }
    }

}
