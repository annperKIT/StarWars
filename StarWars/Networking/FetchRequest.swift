//
//  FetchRequest.swift
//  StarWars
//
//  Created by Annie Persson on 01/10/2019.
//  Copyright © 2019 Annie Persson. All rights reserved.
//
 
import Foundation

// MARK: - Fetch Request

protocol FetchRequest {}

extension FetchRequest {
  
  typealias OnCompleted = (Result<Data, FetchError>) -> Void
  
  func fetchFrom(_ url: URL?, completed: @escaping OnCompleted) {
    
    guard let url = url else {
      return completed(.failure(.invalidUrl))
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
      
      if let _ = error {
        return completed(.failure(.serverError))
      }
      
      guard let data = data else {
        return completed(.failure(.missingData))
      }
      
      completed(.success(data))
    }
    
    task.resume()
  }
  
}

// MARK: - FetchError

enum FetchError: Error {
  case invalidUrl
  case serverError
  case missingData
}

extension FetchError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidUrl: return "Make sure to use a valid url string"
    case .serverError: return "An error occured on the server while handling the request"
    case .missingData: return "No data was returned from the server"
    }
  }
}
