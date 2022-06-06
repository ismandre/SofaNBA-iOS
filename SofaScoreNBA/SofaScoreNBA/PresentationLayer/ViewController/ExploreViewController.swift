//
//  SearchViewController.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 13.05.2022..
//

import UIKit
import BTNavigationDropdownMenu

class ExploreViewController: UIViewController {
    
    private var viewModel = ExploreViewModel()
    private var playersDisplayed = true
    
    var tableView = UITableView()
    var searchController = UISearchController(searchResultsController: nil)
    
    var allEntitiesLabel = UILabel()
    
    var filteredPlayers = [Player]()
    var filteredTeams = [Team]()
    
    let cellSpacingHeight: CGFloat = 10
    
    var selectedCellLabel: UILabel = UILabel()
    var menuView: BTNavigationDropdownMenu!
    
    struct Cells {
        static let identifier = "cell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayers()
        loadTeams()
        configureUI()
    }
    
    private func loadTeams() {
        viewModel.fetchTeamsData {
            self.tableView.reloadData()
        }
    }
    
    private func loadPlayers() {
        viewModel.fetchPlayersData {
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 246/255, alpha: 1)
        configureNavigationBar()
        configureDropdownMenu()
        configureTableView()
        configureAllEntitiesLabel()
        configureSearchController()
    }
    
    func configureAllEntitiesLabel() {
        view.addSubview(allEntitiesLabel)
        allEntitiesLabel.text = "All players"
        allEntitiesLabel.textColor = .systemGray
        allEntitiesLabel.font = allEntitiesLabel.font.withSize(20)
        setAllEntitiesLabelConstraints()
    }
    
    func setAllEntitiesLabelConstraints() {
        allEntitiesLabel.translatesAutoresizingMaskIntoConstraints                        = false
        allEntitiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive   = true
        allEntitiesLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10).isActive     = true
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Players..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.scopeButtonTitles = ["All", "BOS", "DET", "MEM", "SAC"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Explore"
        navigationController?.navigationBar.barTintColor = .systemBlue
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        // navigationController?.navigationBar.barStyle = .black
        // navigationController?.navigationBar.tintColor = .white
        
        let logo = UIImage(named: "nba_logo.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
    }
    
    func configureDropdownMenu() {
        let items = ["Players", "Teams"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(0), items: items)

        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = .blue
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            self.playersOrTeamsChosenFromDropdown(indexPath: indexPath, items: items)
        }
        
        self.navigationItem.titleView = menuView
    }
    
    func playersOrTeamsChosenFromDropdown(indexPath: Int, items: [String]) {
        self.selectedCellLabel.text = items[indexPath]
        let category = items[indexPath]
        allEntitiesLabel.text = "All " + category.lowercased()
        searchController.searchBar.placeholder = "Search " + category + "..."
        playersDisplayed = !playersDisplayed
        tableView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(PlayerTeamCell.self, forCellReuseIdentifier: Cells.identifier)
        tableView.backgroundColor = UIColor.clear
        setTableViewConstraints()
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
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if playersDisplayed {
            filteredPlayers = viewModel.players.filter({ (player: Player) -> Bool in
                let doesCategoryMatch = (scope == "All") || (player.team?.abbreviation == scope)
                
                if isSearchBarEmpty() {
                    return doesCategoryMatch
                } else {
                    return doesCategoryMatch && (player.lastName!.lowercased().contains(searchText.lowercased()) || player.firstName!.lowercased().contains(searchText.lowercased()))
                }
            })
        } else {
            filteredTeams = viewModel.teams.filter({ (team: Team) -> Bool in
                let doesCategoryMatch = (scope == "All") || (team.fullname!.lowercased().contains(scope.lowercased()))
                
                if isSearchBarEmpty() {
                    return doesCategoryMatch
                } else {
                    return doesCategoryMatch && team.fullname!.lowercased().contains(searchText.lowercased())
                }
            })
        }
        
        tableView.reloadData()
    }
                                             
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }

}

extension ExploreViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}


extension ExploreViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
        
    }
}


extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (playersDisplayed) {
            if isFiltering() { return filteredPlayers.count }
            return viewModel.players.count
        } else {
            if isFiltering() { return filteredTeams.count }
            return viewModel.teams.count
        }
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("row selected", indexPath.row, indexPath.section)
    // }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.identifier, for: indexPath) as! PlayerTeamCell
        
        let player: Player
        let team: Team
        
        if playersDisplayed {
            if isFiltering() {
                player = filteredPlayers[indexPath.row]
            } else {
                player = viewModel.players[indexPath.row]
            }
            cell.setCellWithValuesOf(isPlayer: playersDisplayed, name: player.firstName! + " " + player.lastName!, origin: player.team!.abbreviation, id: player.id!, row: indexPath.row)
            if UserDefaultsManager.isAdddedPlayer(playerName: player.firstName! + " " + player.lastName!) {
                let image = UIImage(systemName: "star.fill")?.withTintColor(.systemRed)
                cell.favoritesButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "star")?.withTintColor(.systemRed)
                cell.favoritesButton.setImage(image, for: .normal)
            }
            
        } else {
            if isFiltering() {
                team = filteredTeams[indexPath.row]
            } else {
                team = viewModel.teams[indexPath.row]
            }
            cell.setCellWithValuesOf(isPlayer: playersDisplayed, name: team.fullname, origin: "", id: team.id!, row: indexPath.row)
            
            if UserDefaultsManager.isAddedTeam(teamName: team.fullname!) {
                let image = UIImage(systemName: "star.fill")?.withTintColor(.systemRed)
                cell.favoritesButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "star")?.withTintColor(.systemRed)
                cell.favoritesButton.setImage(image, for: .normal)
            }
        }
        
        cell.favoritesButton.addTarget(self, action: #selector(favoritesClicked(sender:)), for: .touchUpInside)
        cell.favoritesButton.tag = indexPath.row
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.clear.cgColor
        
        return cell
    }
    
    @objc func favoritesClicked(sender: UIButton) {
        if playersDisplayed {
            let player = viewModel.players[sender.tag]
            if UserDefaultsManager.isAdddedPlayer(playerName: player.firstName! + " " + player.lastName!) {
                // remove item from favorites
                UserDefaultsManager.removePlayerInfo(playerName: player.firstName! + " " + player.lastName!)
                // update star shape
                let image = UIImage(systemName: "star")?.withTintColor(.systemRed)
                sender.setImage(image, for: .normal)
            } else {
                // add item to favorites
                UserDefaultsManager.storePlayerInfo(playerName: player.firstName! + " " + player.lastName!, playerOrigin: player.team!.abbreviation)
                // update star shape
                let image = UIImage(systemName: "star.fill")?.withTintColor(.systemRed)
                sender.setImage(image, for: .normal)
            }
        } else {
            let team = viewModel.teams[sender.tag]
            if UserDefaultsManager.isAddedTeam(teamName: team.fullname!) {
                // remove item from favorites
                UserDefaultsManager.removeTeamInfo(teamName: team.fullname!)
                // update star shape
                let image = UIImage(systemName: "star")?.withTintColor(.systemRed)
                sender.setImage(image, for: .normal)
            } else {
                // add item to favorites
                UserDefaultsManager.storeTeamInfo(teamName: team.fullname!)
                // update star shape
                let image = UIImage(systemName: "star.fill")?.withTintColor(.systemRed)
                sender.setImage(image, for: .normal)
            }
        }
    }
    
}




