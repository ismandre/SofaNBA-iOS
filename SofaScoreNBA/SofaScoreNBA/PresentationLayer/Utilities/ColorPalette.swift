//
//  Colors.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation
import UIKit

class ColorPalette {
    
    let teamsPrimary = [
        "Atlanta Hawks" : UIColor(red: 224/255, green: 58/255, blue: 62/255, alpha: 1),
        "Boston Celtics" : UIColor(red: 0, green: 122/255, blue: 51/255, alpha: 1),
        "Brooklyn Nets" : UIColor(red: 45/255, green: 41/255, blue: 37/255, alpha: 1),
        "Charlotte Hornets": UIColor(red: 0/255, green: 140/255, blue: 168/255, alpha: 1),
        "Chicago Bulls": UIColor(red: 206/255, green: 17/255, blue: 65/255, alpha: 1),
        "Cleveland Cavaliers": UIColor(red: 134/255, green: 0, blue: 56/255, alpha: 1),
        "Dallas Mavericks": UIColor(red: 0, green: 125/255, blue: 197/255, alpha: 1),
        "Denver Nuggets": UIColor(red: 14/255, green: 34/255, blue: 64/255, alpha: 1),
        "Detroit Pistons": UIColor(red: 29/255, green: 66/255, blue: 186/255, alpha: 1),
        "Golden State Warriors": UIColor(red: 29/255, green: 66/255, blue: 138/255, alpha: 1),
        "Houston Rockets": UIColor(red: 57/255, green: 58/255, blue: 53/255, alpha: 1),
        "Indiana Pacers": UIColor(red: 252/255, green: 180/255, blue: 36/255, alpha: 1),
        "LA Clippers": UIColor(red: 200/255, green: 16/255, blue: 46/255, alpha: 1),
        "Los Angeles Lakers": UIColor(red: 85/255, green: 37/255, blue: 131/255, alpha: 1),
        "Memphis Grizzlies": UIColor(red: 93/255, green: 118/255, blue: 169/255, alpha: 1),
        "Miami Heat": UIColor(red: 152/255, green: 0, blue: 46/255, alpha: 1),
        "Milwaukee Bucks": UIColor(red: 0/255, green: 71/255, blue: 27/255, alpha: 1),
        "Minnesota Timberwolves": UIColor(red: 0, green: 79/255, blue: 131/255, alpha: 1),
        "New Orleans Pelicans": UIColor(red: 0, green: 42/255, blue: 91/255, alpha: 1),
        "New York Knicks": UIColor(red: 242/255, green: 103/255, blue: 41/255, alpha: 1),
        "Oklahoma City Thunder": UIColor(red: 0, green: 122/255, blue: 193/255, alpha: 1),
        "Orlando Magic": UIColor(red: 0/255, green: 119/255, blue: 192/255, alpha: 1),
        "Philadelphia 76ers": UIColor(red: 0/255, green: 107/255, blue: 182/255, alpha: 1),
        "Phoenix Suns": UIColor(red: 29/255, green: 17/255, blue: 96/255, alpha: 1),
        "Portland Trail Blazers": UIColor(red: 224/255, green: 58/255, blue: 62/255, alpha: 1),
        "Sacramento Kings": UIColor(red: 92/255, green: 102/255, blue: 111/255, alpha: 1),
        "San Antonio Spurs": UIColor(red: 158/255, green: 166/255, blue: 172/255, alpha: 1),
        "Toronto Raptors": UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        "Utah Jazz": UIColor(red: 249/255, green: 161/255, blue: 26/255, alpha: 1),
        "Washington Wizards": UIColor(red: 0/255, green: 43/255, blue: 92/255, alpha: 1)
    ]
    
    func getTeamsPrimary() -> [String: UIColor] {
        return teamsPrimary
    }
}
