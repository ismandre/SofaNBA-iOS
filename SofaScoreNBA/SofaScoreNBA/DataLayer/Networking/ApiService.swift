//
//  ApiService.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getPlayersData(completion: @escaping (Result<PlayersData, Error>) -> Void) {
        
        let playersDataURL = "https://balldontlie.io/api/v1/players"
        
        guard let url = URL(string: playersDataURL) else { return }
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            // Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty data
                print("Empty data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PlayersData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        })
        
        dataTask?.resume()
    }
    
    
    func getTeamsData(completion: @escaping (Result<TeamsData, Error>) -> Void) {
        
        let teamsDataURL = "https://balldontlie.io/api/v1/teams"
        
        guard let url = URL(string: teamsDataURL) else { return }
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            // Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle empty data
                print("Empty data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TeamsData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }

        })
        
        dataTask?.resume()
    }
    
    func getImagesForPlayerId(playerId: Int, completion: @escaping (Result<PlayerImages, RequestError>) -> Void) {
        
        let playerImagesURL = "https://academy-2022.dev.sofascore.com/api/v1/academy/player-image/player/" + String(playerId)
        
        guard let url = URL(string: playerImagesURL) else { return }
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            // Handle error
            if let error = error {
                completion(.failure(.serverError))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                // Handle Empty Response
                print("Empty Response")
                completion(.failure(.noData))
                return
            }
            print("Response status code: \(response.statusCode)")
            guard let data = data else {
                // Handle empty data
                print("Empty data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PlayerImages.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch _ {
                completion(.failure(.dataEncodingError))
            }

        })
        
        dataTask?.resume()
    }
}
