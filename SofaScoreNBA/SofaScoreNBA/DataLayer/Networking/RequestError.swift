//
//  RequestError.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataEncodingError
}
