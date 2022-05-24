//
//  SearchViewController.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 13.05.2022..
//

import UIKit

class ExploreViewController: UIViewController {
    
    var tableView = UITableView()
    var teams: [Team] = []
    
    let cellSpacingHeight: CGFloat = 10
    
    struct Cells {
        static let teamCell = "teamCell"
        static let playerCell = "playerCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 246/255, alpha: 1)
        
        teams = fetchData()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        // set delegates
        setTableViewDelegates()
        // set row height
        tableView.rowHeight = 100
        // register cells
        tableView.register(TeamCell.self, forCellReuseIdentifier: Cells.teamCell)
        // set constraints
        setTableViewConstraints()
        // make table transparent
        tableView.backgroundColor = UIColor.clear
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints                        = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive           = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive   = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive     = true
    }

}


extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.teamCell) as! TeamCell
        let team = teams[indexPath.section]
        cell.set(team: team)
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.clear.cgColor
        
        return cell
    }
}

extension ExploreViewController {
    
    func fetchData() -> [Team] {
        let team1 = Team(image: UIImage(named: "atlanta_hawks")!, name: "Atlanta Hawks")
        let team2 = Team(image: UIImage(named: "steven_adams")!, name: "Steven Adams")
        let team3 = Team(image: UIImage(named: "atlanta_hawks")!, name: "Atlanta Hawks")
        let team4 = Team(image: UIImage(named: "steven_adams")!, name: "Steven Adams")
        let team5 = Team(image: UIImage(named: "atlanta_hawks")!, name: "Atlanta Hawks")
        let team6 = Team(image: UIImage(named: "steven_adams")!, name: "Steven Adams")
        let team7 = Team(image: UIImage(named: "atlanta_hawks")!, name: "Atlanta Hawks")
        let team8 = Team(image: UIImage(named: "steven_adams")!, name: "Steven Adams")
        let team9 = Team(image: UIImage(named: "atlanta_hawks")!, name: "Atlanta Hawks")
        
        return [team1, team2, team3, team4, team5, team6, team7, team8, team9]
    }
}
