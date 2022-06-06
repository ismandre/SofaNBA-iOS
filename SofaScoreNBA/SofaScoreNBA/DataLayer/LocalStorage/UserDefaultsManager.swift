//
//  UserDefaultsManager.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 06.06.2022..
//

import Foundation

class UserDefaultsManager {
    
    static let userDefaults = UserDefaults.standard
    
    static func storePlayerInfo(playerName: String, playerOrigin: String) {
        var playerNames = userDefaults.stringArray(forKey: "playerNames") ?? []
        var playerOrigins = userDefaults.stringArray(forKey: "playerOrigins") ?? []
        
        playerNames.append(playerName)
        playerOrigins.append(playerOrigin)
        
        userDefaults.set(playerNames, forKey: "playerNames")
        userDefaults.set(playerOrigins, forKey: "playerOrigins")
    }
    
    static func getNumberOfPlayerRecords() -> Int {
        let playerNames = userDefaults.stringArray(forKey: "playerNames") ?? []
        return playerNames.count
    }
    
    static func removePlayerInfo(playerName: String) {
        var playerNames = userDefaults.stringArray(forKey: "playerNames") ?? []
        var playerOrigins = userDefaults.stringArray(forKey: "playerOrigins") ?? []
        let position = playerNames.firstIndex(of: playerName)
        guard let index = position else { return }
        playerNames.remove(at: index)
        playerOrigins.remove(at: index)
        userDefaults.set(playerNames, forKey: "playerNames")
        userDefaults.set(playerOrigins, forKey: "playerOrigins")
    }
    
    static func getPlayersInfo(index: Int) -> [String: String] {
        let playerNames = userDefaults.stringArray(forKey: "playerNames") ?? []
        let playerOrigins = userDefaults.stringArray(forKey: "playerOrigins") ?? []
        
        return [
            "playerName": playerNames[index],
            "playerOrigin": playerOrigins[index]
        ]
    }
    
    static func storeTeamInfo(teamName: String) {
        var teamNames = userDefaults.stringArray(forKey: "teamNames") ?? []
        teamNames.append(teamName)
        userDefaults.set(teamNames, forKey: "teamNames")
    }
    
    static func getTeamsInfo(index: Int) -> [String: String] {
        let teamsNames = userDefaults.stringArray(forKey: "teamNames") ?? []
        
        return [
            "teamName": teamsNames[index]
        ]
    }
    
    static func getNumberOfTeamRecords() -> Int {
        let teamNames = userDefaults.stringArray(forKey: "teamNames") ?? []
        return teamNames.count
    }
    
    static func removeTeamInfo(teamName: String) {
        var teamNames = userDefaults.stringArray(forKey: "teamNames") ?? []
        let position = teamNames.firstIndex(of: teamName)
        guard let index = position else { return }
        teamNames.remove(at: index)
        userDefaults.set(teamNames, forKey: "teamNames")
    }
    
    static func isAdddedPlayer(playerName: String) -> Bool {
        let playerNames = userDefaults.stringArray(forKey: "playerNames") ?? []
        return playerNames.contains(playerName)
    }
    
    static func isAddedTeam(teamName: String) -> Bool {
        let teamNames = userDefaults.stringArray(forKey: "teamNames") ?? []
        return teamNames.contains(teamName)
    }
    
    static func removePlayersAndTeamsRecords() {
        userDefaults.removeObject(forKey: "playerNames")
        userDefaults.removeObject(forKey: "playerOrigins")
        userDefaults.removeObject(forKey: "teamNames")
    }
}
