//
//  ViewController.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 13.05.2022..
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var tableView = UITableView()
    var allEntitiesLabel = UILabel()
    
    var players: [Player] = []
    var teams: [Team] = []
    
    struct Cells {
        static let identifier = "cell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 246/255, alpha: 1)
        
        // players = fetchPlayers()
        // teams = fetchTeams()
        
        configureNavigationBar()
        configureTableView()
        // configureAllEntitiesLabel()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemBlue
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // navigationController?.navigationBar.barStyle = .black
        // navigationController?.navigationBar.tintColor = .white
        
        let logo = UIImage(named: "nba_logo.png")
        let imageView = UIImageView(image: logo)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        let favoritesLabel = UILabel()
        favoritesLabel.text = "Favorites"
        favoritesLabel.textColor = .white
        self.navigationItem.titleView = favoritesLabel
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .white

    }
    
    @objc func editTapped() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        print("edit tapped")
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        self.tableView.isEditing = true
    }
    
    @objc func doneTapped() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        print("done tapped")
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        self.tableView.isEditing = false
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(PlayerTeamCell.self, forCellReuseIdentifier: Cells.identifier)
        setTableViewConstraints()
        tableView.backgroundColor = UIColor.clear
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints                        = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive           = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive   = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive     = true
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // players
            print("number of players: ", UserDefaultsManager.getNumberOfPlayerRecords())
            return UserDefaultsManager.getNumberOfPlayerRecords()
        } else { // teams
            print("number of teams: ", UserDefaultsManager.getNumberOfTeamRecords())
            return UserDefaultsManager.getNumberOfTeamRecords()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Players"
        } else {
            return "Teams"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //    let headerView = UIView()
    //    headerView.backgroundColor = UIColor.clear
    //    return headerView
    // }
    
    // func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("row selected", indexPath.row, indexPath.section)
    // }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.identifier, for: indexPath) as! PlayerTeamCell
        
        if indexPath.section == 0 {
            let player = UserDefaultsManager.getPlayersInfo(index: indexPath.row)
            print("player: ", player)
            cell.setCellWithValuesOf(isPlayer: true, name: player["playerName"]!, origin: player["playerOrigin"]!, id: 0, row: indexPath.row)
        } else {
            let team = UserDefaultsManager.getTeamsInfo(index: indexPath.row)
            print("team: ", team)
            cell.setCellWithValuesOf(isPlayer: false, name: team["teamName"], origin: "", id: 0, row: indexPath.row)
        }
                
        // cell.favoritesButton.addTarget(self, action: #selector(favoritesClicked(sender:)), for: .touchUpInside)
        cell.favoritesButton.tag = indexPath.section
        
        let image = UIImage(systemName: "star.fill")?.withTintColor(.systemRed)
        cell.favoritesButton.setImage(image, for: .normal)
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.clear.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        /*
        let movedObject: Entity
        if sourceIndexPath.section == 0 {
            movedObject = players[sourceIndexPath.row]
            players.remove(at: sourceIndexPath.row)
            players.insert(movedObject, at: destinationIndexPath.row)
        } else {
            movedObject = teams[sourceIndexPath.row]
            teams.remove(at: sourceIndexPath.row)
            teams.insert(movedObject, at: destinationIndexPath.row)
        }
         */
    }
    
}

