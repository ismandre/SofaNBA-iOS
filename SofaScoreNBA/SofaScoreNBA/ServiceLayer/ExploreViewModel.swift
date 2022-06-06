//
//  ExploreViewModel.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation

class ExploreViewModel {
    
    private var apiService = ApiService()
    var players = [Player]()
    var teams = [Team]()
    
    func fetchPlayersData(completion: @escaping () -> ()) {
        apiService.getPlayersData { (result) in
            switch result {
            case .success(let listOf):
                self.players = listOf.data
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func fetchTeamsData(completion: @escaping () -> ()) {
        apiService.getTeamsData { (result) in
            switch result {
            case .success(let listOf):
                self.teams = listOf.data
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfPlayersInSection(section: Int) -> Int {
        if players.count != 0 {
            return players.count
        }
        return 0
    }
    
    func playerForRowAt(indexPath: IndexPath) -> Player {
        return players[indexPath.row]
    }
}
